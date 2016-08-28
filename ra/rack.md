##Rack
一个web应用接口

### Rack应用
一个 rack app就是一个ruby对象 这个对象提供一个call方法
只接受一个env 参数，返回一个三元数据．
 1. HTTP响应码，
 2. 响应头-> Hash
 3. 响应body对象, 需要能够有.each方法



###配置
config.ru 是rack的配置文件
config.ru << EOF
  run Proc.new { |env| ['200', {'Content-Type' => 'text/html'}, ['get rack\'d']] }
  map '/books' do
    run Proc.new { |env| ['200', {'Content-Type' => 'text/html'}, ['get rack\'d']] }
  end
EOF

* run 是一个方法，接受一个app对象
* map 匹配指定的URL路径

### rackup
一个工具，配置和启动rack中间件和 应用


* 开启一个最小的Ruby Web server
  ruby -run -e httpd . -p 3000
  un.rb 是一个内置的HTTPServer 模块
  -e 后门的是参数


### 工作机制
主要是实现了中间件机制, 每个中间件都会改变HTTP请求或响应的内容


handler/
 实现对cfg/fcfi/sfgi/thin/webrick 等web Server(容器)的启动
 def self.run(app, options) 接受一个应用, 开启web server, 
   发送app 返回的HTTP status, headers, body
   status, headers, body = @app.call(env)
   Rack 规定了一个App 如何返回

env 
  发送的HTTP 请求都会被解析为一个env 对象, Rack 把env 传递给app

### 中间件
使用 use 方法来使用中间件
EOF <<
use Rack::Static,
                 :urls => ["/images", "/js", "/css"],
                 :root => "public"

run lambda { |env|
  [
    200,
    {
      'Content-Type'  => 'text/html',
      'Cache-Control' => 'public, max-age=86400'
    },
    File.open('public/index.html', File::RDONLY)
  ]
}
<< EOF


#### 自定义中间件
每个中间件都是一个rack app. 就是一个对象, 能够响应call
返回三元组
每一个中间件都可以对请求和响应进行控制

class MyMiddleware
  def initialize(app)
    ## 初始化很重要,这里的参数就是rack 下面的中间件
    @app = app
  end

  def call(env)
    ### 前期处理
    code, headers, body = @app.call(env)
    ### 后期处理
    puts "my middle do"
    [status, headers, body << "hahah"]
  end
end

use MyMiddleware
run app

### 中间件的工作方式
中间件之间像是套娃一样，一个包裹着一个

middle1 begin
  middle2 begin
     middle 3 begin
       app 
     middle 3 end
  middle 2 end
middle 1 end

注意每一层的milldeware都有可能独自拦截请求，而不往下转发
比如Rack::Static

### Rack::Builder
一个声明中间件stack的DSL
在不使用config.ru时可以这样写, 
app = Rack::Builder.new do
  use D
  use C
  use B
  run A
end

#### rack 架构与核心概念分析
v2.0

* 中间键实现模式
  修饰着模式
  Rack::Server.start(
    :app => Rack::ShowExceptions.new(Rack::Lint.new(Rack::Lobster.new)), :Port => 9292
  )

核心组件
* Rack::Server
  功能:
   + Rack 的启动入口 start
    #  Rack::Server.start(
    #    :app => lambda do |e|
    #      [200, {'Content-Type' => 'text/html'}, ['hello world']]
    #    end,
    #    :server => 'cgi'
    #  )
   + 处理命令行启动参数 Rack::Server::Options
   + 构造middleware stack
   + 处理信号，停止server

* Rack::Handler
  不同web服务器执行app的接口
  功能:
  1. 与web Server进行连接
  2. 处理web Server发送的HTTP请求
  3. 初始化env, 对每个请求执行app,得到结果发送给web服务器,rack的标准输入输出都以重新定向到web服务器
  
* Builder
  实现一个DSL构造中间件栈
  #  require 'rack/lobster'
  #  app = Rack::Builder.new do
  #    use Rack::CommonLogger
  #    use Rack::ShowExceptions
  #    map "/lobster" do
  #      use Rack::Lint
  #      run Rack::Lobster.new
  #    end
  #  end
  #
  #  run app

### 中间件
* URLMap
  　一个把不同的urls分发到对应的apps
    也就是说每个map都有一个对应的app,rack可能有多个apps

* Static
   * 解析静态文件，使用Rack::File处理
       use Rack::Static, :urls => ["/js", "/img"]
       use Rack::Static, :urls => ["/js", "/img"], :root => "public"
       Rack::Static 的可选参数有， :urls, :index, :gzip, :root
   * 还可以用来匹配url,修改HTTP headers
     具体规则参考代码注释
   * 是静态文件就自己处理，不是就交给下面的app处理,拦截器
  
* Head
   相应HTTP head 请求，只返回HTTP头

* ETag
   实现Etag 功能

* SendFile
  提供sendFile功能,直接设置，返回web server, web Server
  会直接负责文件的发送

* Runtime
   提供设置X-Runtime相应头功能，用来记录服务器的处理时间

* Directory
   提供目录自动生成功能

* MethodOverrid
   重写HTTP method 功能

### files
* mime.rb 工具类
* utils.rb HTTP工具类
