WebSocket 功能

包含full-stack

### 架构
Connection
  Channle
    Stream

一个连接 Connect
频道 Channle 在Connect是一个罗辑单元
每个频道可以有多个 广播 brodcasting

## routes
mount ActionCable.server => '/cable'


module ApplicationCable
  class Connection < ActionCable::Connection::Base
    // Here `identified_by` is a connection identifier that can be used to find the specific connection again or later.
    // Note that anything marked as an identifier will automatically create a delegate by the same name on any channel instances created off the connection.
    // 当连接建立好,就会有一个Connection实例
    // 通过identified_by 添加实例的标记
    identified_by :current_user


    def connect
      self.current_user = find_verified_user
    end

    protected
      def find_verified_user
        if current_user = User.find_by(id: cookies.signed[:user_id])
          current_user
        else
          reject_unauthorized_connection
        end
      end
  end
end

Client
* 创建连接
@App = {}
App.cable = ActionCable.createConsumer("ws://cable.example.com")
对于一个页面多次调用,只会建立一次连接

* RPC
 client 端通过@perform('FuncName') 方法就可以调用server端对应的方法了
 @perform(a,b) 底层还是调用的.send

* 发送数据
send(data) 但是不能直接使用,
全端代码在webSocket上有做了协议封装. 使用@perform调用后端函数
data.action = 调用的方法名

* 调试
ActionCable.startDebugging()
ActionCable.stopDebugging()

* 接收
  received: (data) ->


Stream
  自动发发送jk

## Server 端
* 接收数据,通过方法接收
* 发送数据
    ActionCable.server.broadcast <广播号>, <msg>
*  stream_from "one" 用来订阅这个频道中的某个广播.如果不订阅,是收不到
   这个广播的


