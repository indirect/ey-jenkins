require 'socket'

Dir.chdir(current_path) do
  begin
    TCPSocket.new("127.0.0.1", 3001).close
    `bundle exec jenkins server --kill`
    sleep 5
  rescue Errno::ECONNREFUSED
  end
end