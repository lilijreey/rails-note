## gem install websocket-eventmachine-server

require 'websocket-eventmachine-server'

EM.run do
  WebSocket::EventMachine::Server.start(host: "localhost", port: 5567) do |ws|
    ## 里面的都是回调
    ws.onopen do
      puts "on open..."
      
    end

    ws.onmessage do |msg, type|
      puts "on message..."
      ws.send msg, :type => type
    end

    ws.onclose do
      puts "on close"
    end
  end
end

