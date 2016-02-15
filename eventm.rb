##不是标准库中的 
#事件驱动的ractor模型,单线程网络通信库
#整个书写模式都是传入一个block异步回调模式,类似与nodejs


# 

#EE 优势
#不会有IO阻塞,如果用标准库中的会在一个IO上阻塞整个进程


require 'eventmachine'

#EE 默认使用 select(2), 可以指定使用epoll EM.epoll
EM.epoll if EM.epoll?

##EE EM.run 开始一个event loop, 在当前(ruby)线程上阻塞
# 运行event loop
EventMachine.run do
  puts "EventMachine start"

  #EE EM = EventMachine 是一个别名

  #EE add_timer 添加一个定时器, 指定超时的秒数
  EM.add_timer(2) do
    puts "timer #{Time.now}"

    #EE 停止event loop
    EM.stop
  end

  ##EE Channel
  channel = EM::Channel.new
  ## 订阅后,调用push 方法发出的信息,都会回调订阅的block
  sid = channel.subscribe { |msg| puts "got msg"}
  channel.subscribe { |msg| puts "got msg2"}
  channel.push("hello")

  ## 开启一个TCP server
  #EM.start_sever "localhost", 5000
end
