Dir.chdir(current_path) do
  `bundle exec hudson server --daemon`
end