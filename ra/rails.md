### Rails 架构解析

Rails 是一些gems的集合,所有的gem都被设计为可以独立使用
Rails框架只是一群的遵循Rack规范的Ruby对象彼此间传递着请求和响应实体，这么看来Rails也就没有这么神秘了

###主要的build in Gems

### Rails 入手
1. 搞明白rack see rack.md
2.

### ActiveSupport 
提供了一些工具类,和对内置类型的monkypatch
* autoload 重写了autoload Rails中大量使用
  不需要第二个文件参数，根据默认规则自动加载文件

#### ActionPack
Action Pack is a framework for handling and responding to web requests. 
主要包含三部分
* 提供路由机制 ActionDispatch
* 提供controller基类 ActionController
* 文件渲染Render 

#### Action Dispatch
提供了一些列的中间件
使用 rack middleware 可以查看一个rails项目使用的所有中间件

### ActionDispath::Joureny
Joureny的核心功能是实现Rails路由描述DSL解析器
定义了一个DSL用来解析　path. e.g. /page/:id(/:action)(.:format)

DSL语法解析器使用的是Ruby标准库中的Racc,自动生成的
整个lib的核心是 parser.y 这个文件 这个文件定义了Rails路由DSL的BNF
解析的过程和一般语言的一样，token化，语法解析，从源码生成AST
AST中的每个节点都定义了一个class 在nodes/node.rb中定义
每个节点都是一个终结符号. (要搞懂joureny最主要的还是需要你有一定的编译原理知识,
和懂得.y 文件的语法) 

* token 化的工作也就是(词法分析)是scanner.rb实现的使用了ruby标准库中的strscan实现
* 解析好的ast连同controller, action的信息一起存放在 Journey::Path::Pattern中(path/pattern.rb)
* route.rb 定义的Route用来表示一条完整的路由信息,还提供了一些匹配查询方法
* router.rb 是整个路由分发的入口,从server函数开始,对每一个HTTP请求匹配路由表
   Router类本身也是一个Rake 中间件

这就是Joureny和核心功能．剩下的gtg/, nfa/ 和visitors.rb文件完成了另一个功能
　是路由表的解析过程可视化功能．会把路由的匹配转换为NFA的状态转换图．使用svg绘图生成
　对应的html文件． 这一部分没有细看．



Joureny::Route 一个路由对象

定义路由表 Routes
路由分发入口,实现路由匹配
see http://blog.bigbinary.com/2013/01/29/journey-into-rails-routing.html
path的正规化

### ActionDispath::Http
这个模块提供了一下HTTP相关的工具函数，很好理解
cache.rb 提供了关于HTTP协议cache功能的检测函数,主要是针对
        IF_MODIFIED_SINCE 
        IF_NONE_MATCH
        这两个header
filter_parameter.rb 实现HTTTP 请求参数的重写功能．主要用于在log
  中屏蔽敏感信息

headers.rb 通过从env中提取HTTP　请求header的功能
headers = ActionDispatch::Http::Headers.new(env)


### ActionDispath::Routing
Routing模块用来实现从path到controller#action的路由过程

  module Routing
    extend ActiveSupport::Autoload

    autoload :Mapper 定义路由函数
    autoload :RouteSet ## 一组路由集合
    autoload :RoutesProxy
    autoload :UrlFor ##helper 用于生成url　
    autoload :PolymorphicRoutes ##helper 用于生成url
  end


添加自定义中间件

config/environments/development.rb

Racktest::Application.configure do
  ## 在Static 之前
  config.middleware.insert_before ActionDispatch::Static, MyMiddleware
end
