Dir.chdir(current_path) do
  `bundle exec hudson server --daemon`
  `sudo /etc/init.d/nginx restart`
end