## Rails Cache 机制


### 目的
* 加速应用响应
* cache机制会存储在http请求-响应过程中动态产生的内容,并重用

### 用途
* 增加处理能力


### 设计方式
* Rails的cache系统包含一系列的特性
 包含: 1. page
       2. action
       3. fragment

* 默认情况先cache机制只会在生产环境下开启
 由 config.action_controller.perform_caching 控制

### page cache
+ page cache 是可以让web server(Nginx,Apache)直接返回原来生成的页面,而
  不需要进入Rails App

+ 在4后被移出
 需要增加 actionpack-page_caching gem

+ 不能应用于所有情况, 只能对所有人都相同的页面可以

+ page cache 机制不能被用于有前提条件的actions, 比如权限验证

### action cache
+ 和page cache类似,可以用于有前提条件的action
+ 被从4移出

### fragment cache


### 缓存的存储方式
Rails提供了多种方式,存储缓存
1. config.cache_store = :memory_store{size:64.megabytes}


### SQL Caching
在同一action中如果执行同一查询多次，则只会实际执行一次
e.g.
User.all
User.all
User.all

但是有的时候不行
User.all.last
User.all
会执行两次



