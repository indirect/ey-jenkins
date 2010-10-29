namespace :db do

  desc "Configure Nginx reverse proxy to Hudson"
  task :migrate do
    unless File.exist?("/data/nginx/servers")
      puts "This doesn't look like an EY instance..."
      next
    end

    orig = "/data/nginx/servers/hudson.conf"
    FileUtils.rm_rf(orig) if File.exist?(orig)

    conf = "/data/nginx/servers/keep.hudson.conf"
    if File.exist?(conf)
      puts "There's already a file at #{conf}"
      next
    end

    sh "sudo /etc/init.d/nginx stop"
    File.open(conf, "w") do |f|
      f.write <<-NGINX
        server {
          listen 80;

          server_name _;

          client_max_body_size 100M;

          root /data/hudson/current/public;

          access_log /var/log/engineyard/nginx/hudson.access.log main;

          error_log /var/log/engineyard/nginx/hudson.error.log notice;

          # passenger_enabled on;
          #
          # rack_env production;
          #
          # include /etc/nginx/servers/hudson.rewrites;
          #
          # include /etc/nginx/servers/hudson/custom.locations.conf;

          # This allows people to use images and css in their maintenance.html file
          if ($request_filename ~* \.(css|jpg|gif|png)$) {
            break;
          }

          # Rewrite all the requests to the maintenance.html page if it exists.
          if (-f $document_root/system/maintenance.html) {
            return 503;
          }

          # set Expire header on assets: see http://developer.yahoo.com/performance/rules.html#expires
          location ~ ^/(images|javascripts|stylesheets)/ {
            expires 10y;
          }

          error_page 404 /404.html;
          error_page 500 502 504 /500.html;

          error_page 503 @503;
          location @503 {
            rewrite  ^(.*)$  /system/maintenance.html break;
          }

          location / {
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto https;
            proxy_set_header Host $http_host;
            proxy_next_upstream error;
            proxy_pass http://localhost:3001;
          }

        }
      NGINX
      sleep 2
      sh "sudo /etc/init.d nginx start"
    end
  end

end