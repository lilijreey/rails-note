## view
* bower-rails
gem "bower-rails"
 1. 生成配置文件 bower.json
   rails g bower_rails:initialize json
 2.
   rails g bower_rails:initialize 
    会生成一个Bowerfile 的文件，类似与json, 不过是Ruby 的DSL
    也是用来声明使用项目的

  + 其实就是用bower来管理所有前端第三方资源
  + rake -T bower 显示所有命令
     rake bower:insert
     rake bower:list
  + 与Rails集成 直接使用bower 命令就可以,不需要带rake 前缀
    资源文件 Bowerfile
    与Gemfile类似列出需要使用的包的名字
    bower 默认用的是bower.json
     e.g. asset  'bootstrap-sass-official'

    4. 添加asset pipeline
     默认会把vendor/assets/bower_components 自动添加到资源搜索路径
     config.assets.paths << Rails.root.join("vendor","assets","bower_components")

    5. 在application.js 中添加
    //=require Name/js

    6. 需要重启server

生成环境预编译:


## ES6 
使用es6 babel代替coffee 在Asset Pipeline中
gem "sprockets"
gem "sprockets-es6"

require "sprockets/es6"
 js 文件的后缀为.es6 e.g. xx.js.es6


# jquery-ui
gem jquery-ui-rails
使用
引入js/css 文件
  
$(document).ready ->
    $("#datepicker").each ->
        $(@).datepicker
          dateFormat: "yy/mm"




* datagrid 快速构造datagrid  数据表单

+ 前端form 字段检查
    gem 'html5_validators'
   根据ActiveModel 和form_for 自动为每个field生成前端检查

+ bootstrap
   这个有好几个rails的版本
 gem 'bootstrap-sass'
    EOF >> <  application.css.scss 
        @import "bootstrap-sprockets";
        @import "bootstrap";
　　EOF 

    EOF >> application.js
      //= require bootstrap-sprockets 注意在jquery后门
    EOF

    重写bootstrap 参数
    可以在@import bootstrap 之前，对bootstrap 的变量进行赋值
     e.g. $xxx = yyyddd


+ 字体
 gem 'font-awesome-sass', '~> 4.4.0'
    EOF >> <  application.css.scss 
      ## 添加这两行，导入字体
	@import "font-awesome-sprockets";
	@import "font-awesome";
　　EOF 

   <i class="fa fa-NAME"></i>

  Rails helper 
  icon('flag')

  
+ haml
    gem 'haml-rails'


+ slim
   gem 'slim-rails'

+ autoprefixer
   gem "autoprefixer-rails"
    用于给css 自动添加兼容前缀
  

+ 分页
   gem 'will_paginate'

+ 富文本编辑器
 ckeditor

heapler
  = cktext_area :notes, :info #必须填入两个名字, 



+ 点评,评分系统 raddit 风格的投票系统
gem 'acts_as_votable', '~> 0.10.0'
  使用
   在model 中添加 acts_as_votable
   然后这个model 就会添加vote 的函数
   在rount, controller 中添加 upvote, downvote 的action
   然会调用model 对应的action
   在view 中显示 vote 值;

    @pin.upvote_by(current_user)
    = link_to like_pin_path(@pin)
    @pin.votes_for.size

    会导出多组函数, like/dislike, up/down 名字不同意义相同


### 功能
* FFI
 一个好用给ruby的写C扩展的包

* gem rails-observers 
　　监控

* gon 
   把Rails变量导入js

* rotp 生成一次性验证密码
  例如短信验证码,有时间过期

* stamp
 date 格式化
 gem stamp
 ruby 原声data和times类型会导出一个 satmp方法



* 权限管理
gem   'cancancan', '~>1.10'
   + cancancan 不关心用的是什么认证机制，他只依赖一个current_user 的方法
     返回user record或者是一个nil

+ gem the_role
  一个动态可设置的角色权限gem


 + rails g cancan:ability
 会生产app/models/ability.rb
   所有的权限规则都在这里声明
ability.rb << EOF
class Ability
  include CanCan::Ability
  def initialize(user) ##这里对user可以执行的操作做设定
       user ||= User.new # guest user (not logged in)

       # 别名
        alias_action :update, :destroy, :to => :modify # 定义所有的update,destroy,等同于modify

       case user.role
       when :admin then
         can :manage, :all #can 是个方法定义在Ability 中
                          # :manage 意思是执行所有的action
       when :root then
         can :new, :Book ## can 用来给每个权限定义可以执行的操作
	                ## can <ActionName> <ControllerClass>
	 can :index, :Book
	 can [:edit, :update], :Book
	 can [:edit, :update], :[Commit, Message]
       else
         can :read, :all ## :read 是cancan自定义的action别名

       end
  end
end
EOF

 + view 
 can? 方法会判断当前user，是否能够执行一个controller 的action
 can? <ActionName> , <ClassName>
 cannot?
  <% if can? :index, Project %>

 + controller
  对每个controller,的action都定义user的访问权限

	def index
	  @projects = Project.all
	  authorize! :index, @project ## authorize用来给每个controller 的action定义
	  在can 中对应的名字
	end
   + 如果不想在每个action中都写authorize! 这句话，可以在controller 的开头写上
     load_and_authorize_resource ## 每个名字都是action的名字



   +捕捉　CanCan::AccessDenied
	class ApplicationController < ActionController::Base
	 # 在ApplicationContorller 中添加
	  rescue_from CanCan::AccessDenied do |exception|
	    redirect_to root_url, :alert => exception.message
	  end
	end

* rbtree
  红黑树

### ActiveRecord
* phonelib
   验证电话号码正确性


* gem 'enumerize'
 ActiveRecord 的枚举

* 给activeRecord 声明一个默认值
gem default_value_for
class User < ActiveRecord::Base
  default_value_for :name, "(no name)"
  default_value_for :last_seen do
    Time.now
  end

default_value_for :age do
    if today_is_sunday?
      20
    else
      30
    end
  end
end

u = User.new ## new 出后就有默认值了,只是在AR 层面,并不是db colnum
u.name       # => "(no name)"
u.last_seen  # => Mon Sep 22 17:28:38 +0200 2008


defore_action :call [,option]
注意defore_action 对返回值并不关心

* mysql 驱动 
gem 'mysql2'

使用mysql 需要先创建DB
config/database.myl >>
development:
  adapter: mysql2
  encoding: utf8
  reconnect: false
  database: xxx
  pool: 5
  username: root
  password: 12345
  host: localhost


* PostgreSQL
gem 'pg' 
安装的时候如果编译失败,
1. apt-get install postgresql-server-dev
2. ARCHFLAGS="arch x86_64" gem install pg
development:
  adapter: postgresql
  encoding: unicode
  database: myapp_development
  pool: 5
  username: myapp
  password: password1

test:
  adapter: postgresql
  encoding: unicode
  database: myapp_test
  pool: 5
  username: myapp
  password: password1

rake db:create

### 开放辅助 develeop
* gem 'better_errors'
  gem 'binding_of_caller'
  一个更好的错误显示

* timecop 虚拟时间

* annotate
  gem 'annotate', '2.6.5'
  generate modele fields type comment in Module.rb
  annotate -p before


* view file liveload 
  gem 'guard-livereload', '~> 2.5', require: false
  guard init
  guard
  rails s
  浏览器还要又liveload插件
  


* markdown md
~~~ruby
 Kramdown::Document.new(md, {auto_ids:false, syntax_highlighter_opts:{line_numbers:false}}).to_html.html_safe
~~~

* N+1 检测
gem 'bullet'
有大量配置可以设定

* 优化Recode显示,表格化
gem hirb
需要　调用 Hirb.enable
可以加到.irbrc中

* Chrome Rails开发插件
  rails_panel
  需要安装
  　gem 'meta_request'

* 友好显示Ruby对象
gem 'awesome_print'

* 检测SQL漏洞
gem 'brakeman'

* 

## debugger
gem 'byebug'
  调试功能
  在需要断电的地方写入
    byebug
  e.g.
  def index
    byebug
  end
指令和gdb 类似，使用help得到帮助

gem 'debug_view_helper'
查看内部信息


## show debug info
    = debug(params) if Rails.env.development?


## logger on console
  Rails.logger.debug "sth."

## counter_cache
 用处: 如果一个model A 中有个has_many, xxxs 有需要统计多多少个xxx
       则可以给这个A 添加一个xxxs_count field
       这样Rails 在create 和 destroy 是就会自动更改xxxs_count 这个字段

       在xxx Module 上
       belongs_to :A, :counter_cache => true
        如果要指定名字
       belongs_to :A, :counter_cache => <Name>
