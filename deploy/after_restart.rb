Dir.chdir(current_path) do
  `bundle exec jenkins server --daemon`
  `sudo /etc/init.d/nginx restart`
end