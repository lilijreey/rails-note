### Rails 架构解析

Rails 是一些gems的集合
Rails框架只是一群的遵循Rack规范的Ruby对象彼此间传递着请求和响应实体，这么看来Rails也就没有这么神秘了

###主要的build in Gems

### Rails 入手
1. 搞明白rack
2.

#### ActionPack

#### Action Dispatch
提供了一些列的中间件
使用 rack middleware 可以查看一个rails项目使用的所有中间件


添加自定义中间件

config/environments/development.rb

Racktest::Application.configure do
  ## 在Static 之前
  config.middleware.insert_before ActionDispatch::Static, MyMiddleware
end
