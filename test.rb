#Ruby
#一种基于完全OO 设计的语言

## IRB
load 'x.rb'

##pry
#irb 的替代品,支持debug

##debugger
#see pry.rb
#
#可以调试rails
#gem 'ryp-rails'

#安装rvm
#
# 安装玩rvm 后安装ruby
#rvm install ruby
#
####rvm 使用
# rvm list 显示当然安装的所有ruby
#
#设置默认de ruby 版本
# rvm  use ruby-xxx --default
#
###### gem 使用 类型与npm
# gem help commands 输出所有命令
# gem help <cmd> 查询某个命令
#
# gem source
# change gem source
#
# 升级rvm自己
# rvm get stable
# 
# 
# +config file
#  /home/.gemrc
#
# gem install <GemName> --rdoc
# gem install <GemName> --ri
# gem install rails -v 可以指定版本
#
# gem uninstall rails -v
# 
# 使用rvm 必须以一个login shell 登陆
# 
# gem environment 
#   查看环境
#
# gem which GemName
#   查看指定gem的路径
# gem open GemName
#   直接编辑指定gem
#   
# 查询gems 存放的目录
# gem enviroment gemdir
#
# 清除旧的gem 
# gem cleanup
#
####ruby 安装完后安装rails
# 首先执行 rvm requirements
#  安装库
#
#gem install rails
#跟新gem 源 
# gem sources --help
#  gem sources -l
#  删除gemruby.org sources --remove
#  添加　gem sources -a http:ruby.taobao.org
#  清除cache gem sources gem sources -c
#  跟新　gem sources -u
#  
# gem fetcch xxx
#   只下载
#   
# bundle 有自己的源
# 也需要更新为阿里的 
# 
# bundle config 
# $ bundle config mirror.https://rubygems.org https://ruby.taobao.org
#
#国内镜像:
# 山东大学 'http://ruby.sdutlinux.org/'
# see bundle.md
#  
# 更改gemfile
#
#~> 2.0.3 等同于 >= 2.0.3 并且 < 2.1
#~> 2.1 等同于 >= 2.1 并且 < 3.0

## doc help  查询文档
# RDoc 是一个嵌入式文档生成器，扫描源码生成文档，like docexy 
# 可以生成 html 或 ri 格式的文档
#ruby 有两种文档格式 
# ri
#  应该使用ri
#  e.g. 
#  ri File
#  ri xx.yy
#  
#  ri -i 交互模式
#
#  首先擦看 ~/.gemrc
#   确保没有 --no-ri  可以有 --no-rdoc
#   以后所有的gem 都会有ri 文档
#   2. 给所有没有ri 的gem ruby 生成ri 
#      rvm docs generate-ri
#  
# rdoc
rvm docs generate

## ruby -y xx.rb
# 打印语法分析信息 parse

## ruby --dump parsetree x.rb

rtags
生成　tags 的工具
 rtags -vi files

compile
-------------------------------------
TODO

## ruby 函数编程
## map
## each


## reduce
[3,4,5].reduce(:+)
[3,4,5].reduce(0) {|acc, v| acc+ v} # 和上面一样 0是acc的默认值

## inject 是reduce 的别名
[3,4,5,].inject do |acc, v| 
  acc + v
end

## select

## one?
## all?

对于hash v 为list[k,v]
a.reduce(0) {| acc, (k,v)| acc + v}

#
#
# class 变量 和类实例变量
# @@xx 从属于class 对象(ruby 中一个class 也是一个对象)
 
# instance_of? 判断是不是某个类的实例
# is_a? 判断是不是继承过来的

##class 是一段运行的代码，并不给编译器看，和C++/Java中的class的概念还不太相同

class Point
  @@n = 0 ## 类变量，访问需要通过方法,类变量不是真正属于class,而是属于Object
  @n = 1 ## 类的实例变量， 当前self = Point
        ## 只能被class 自己访问

  ## 在调用　Point.new 是会自动调用这个方法
  # 所有传递给new 的参数都会给initialize
  # new 方法是自动导出的
  def initialize(x,y) 
    #当前self 是Point的 instance
    @x, @y = x, y ## @xxx 实例变量，绑定的值这个ｃｌａｓｓ　的一个实例
  end

  ## 类方法, Point.xxx 
  ## 三种定义语法
  # 1. def Point.n()
  # 2. def self.n()
  # 3. class << Point
  #      def n()
  # 
  ## 这里的self 指向的就是Point class obj 本身
  #
  ## 和instance obj 每关系
  ## 访问Class Point.n
  ## 可以被子类继承和修改
  def self.n()
    
    return @@n += 1
  end

  ## EE 属性，like C#, name 会被作为@name, 自动导出geter/seter
  ## attr_accessor :name
  # attr_reader
  # attr_writer
 
  class << self; attr_accessor :classObjVal end
  @classObjVal 
  ## class level obj instance-varible
  ## 使不能从外面直接访问的需要定义函数访问
  ## 或者直接使用 attr_reader :classObjVal 会自动生成访问方法
end

#private:
#  只作用于方法
# 
# instance variab/ class variabl always privare

## 嵌套类
class XX
  class Sub
  end
end

##引用时使用外部class::
# e.g. XX::Sub
#也可以在外部定义
class XX::Other
end


### EE inhiance
class Base
  def initialize(n)
    @n = n
  end
end

class One < Base
  ##EE 将会自动调用父类的init 方法，如果有的话
  #而且是调用和子类相同参数的父类init 方法, 如果没有相同参数的方法，则就会报错
  # One.new 会调用Base.init()
  # 也可以使用 super 来指定父类个构造
  def initialize()
    super(3) ## init super
  end
end

继承也可以使用 Class.new 来实现
One = Class.new(Base) do
  def initialize() 
    xxx
  end
end


### Module
# Class 类是module 的子类, 类是一种特殊形式的module
# Root module 是 Kernel
# 使用module 的主要目的是，模块化代码
# 
# 模块没有实例, 但是可以又实例方法,一般无法访问。一般用在class include module
# 不能继承
#
# 以模块方式提供的方法必须使用 Module.func 来调用
# 引入模块　require 'xxx'
#   不需要xxx.rb 
#   在$LOAD_PATH　中查找xxx.rb
#
# require_relative 'xxx
#   是在当前目录下加载　./xxx.rb
#   == require './xx'
#   只会加载指定文件中的代码,并不会加载其他文件中相同module下的代码
#
# 
# 使用include 则可以将模块中的所有定义混入到当前命名空间中
# 注意模块中所有的非self 方法
#e.g. 
moudel M
  def m1 ## include 会被继承
  end
  def self.m2 ## 属于M 不会被继承
  end
end
class A 
  incldue M # 只继承　m1,作为实例方法
  extern M # 只继承　m1, 作为类方法
end
#
# 将模块混入类中称为 Mix-in, 可以使得多个class 复用相同的代码
#  本质上是在class的祖先链中加入模块
# 
# 使用extend替换include 后，只是模块中的方法都变为的类方法，而不是实例方法
#
#
# 
# 导出模块方法，　模块中定义的方法都只能在本模块内部使用，如果
# 导出方法要使用　module_funciton :xxx
# 
# 作为　namespaces 使用
# 实现　mixin
# 
# 使用　Module.fn 调用方法
# 使用　Module::xxx 访问常量
# 
# autoload :Symbol, "file"
#   延迟加载, 第一个参数必须是一个模块名或者是Class名，在file中定义的
#   只要是触发加载就会加载整个文件，而不是只是指定的符号
#   使用Object.const_missing机制实现的

## 变量 variab
# 1. 局部
# 2. 全局
#    以$开头
#    
# 3. 实例
#    以@开头
#    
# 4. 类变量
#   以@@开头
#   
#

## ruby 有一个内置的变量　caller : Array
#存放当前的调用堆帧
# fileName:line:in FunctionName


# 内置
# __FILE__ -> 返回string 当前文件名
# __LINE__ -> int 行数
# 
# $LOAD_PATH 加载gem的路径
# 
# 特殊变量
# 
# $! last error
# $@ last error line
#
# 
# 每个obj 都有一个id
#  obj.object_id
#  
# 同一性使用　equal?来判定
#   e.g. obj.equal?(obj2)
#
# 值的相等性　使用 == 来判定
# 或者　eq?
 
# === 
# 对不同的类型，比较的意思不同


## loop
# for
#  for i in 1..4 do
#     xxx
#  end
# 
# while
#   while exp do
#     xxx
#   end
# 
# loop
#   e.g.
#   loop { xxx}
#
# 
# 通过方法实现的
# xx.times
#   e.g. 
#   5.times {
#     xxx
#   }
#   
#   5.times do
#     xxx
#   end
# 
#   5.times {|index|
#     xxx
#   end
# 
# each
#  e.g.
#    list.each{ |e|; p e}
#    
## 循环控制
# return
# break
# next == C continue
# redo


## function 
#分类
#1. 实例方法
#   调用的对象为obj
#   
#2. 类方法
#   调用的对象为Class
#   
#3. 函数方法
#    没有调用对象的方法. 也就是普通函数

## 返回值
#  最后一个exp 的值
#  return  如果在最后可以省略
 

## 支持默认参数
# def xx(name=V)
#   ...
# end

## 支持操作符重载
#
#
#
## Type
#
## type convert
# to_s things to string
# to_i to integers
# to_a to array
#
# "fef".to_i
# 323.to_s
# 
# List
# [3,4,5]
# 
# member
# List.max
# List.sort
# List.map
#  e.g. [1,4,5,6].map { 1} -> [1,1,1,1,1]
#  
#  array << 3 push_back
#  
# 
#EE String
#
#* trim 类似函数
#  strip
#  lstrip
#  rstrip
#
#支持here doc
#a <<EOF
#fjefos 
#fesf fejsof 
#EOF

## EE function
def unFn(a)
  ##...
end

def find_if(fn, aa)
  fn.call(fn.call(aa))
end
传递函数时不能直接写名字，这样默认是调用
find_if(unFn) # error
find_if(:unFn, xx) # ok

如果要对一个变量赋值函数
fn = method(:fnName)


## curry
def add(a,b)
  a + b
end

add_five = method(:add).curry[5]
add_five.call(4) = add(5,4)


list = (1..10)
greater_than = ->(x,y) { y > x }.curry
list.select(&greater_than.(5))
# [6, 7, 8, 9, 10]
list.select(&greater_than.(8))

def gg(e)
  e > 5
end

list.select(&lamdba{|e| e>5})
list.select(&->(e) {e > 5})
list.select(&method(:gg)) ## 把普通方法转成block 传递
## 不能少了& 符号




##EE block
#{ ..}
# do .. end
#所有的block 都可以跟在一个function 后面，如果function 调用的yield 就会调用一个次block
#def cb
#  print one
#  yield(arg1, arg2)
#end
#
# cb {|arg1, arg2| xxx ;}

def aa(&p) #&p 是一种声明格式,如果在调用aa的时候后面有Block,
           #Block 会存放在p中, 如果没有Block,则也不会报错,p中什么也没有
  3
end
aa #=> 3
aa {55} #=>3
## 如何方法后面都可以跟一个Block
#如果方法需要使用Block 则可以调用 yield
# 或则调用.call 方法
#block不能独立存在，同时你也没有办法直接存储或传递它，必须把block挂在某个方法后面。

def bb()
  yield ## 在调用bb 时必须根一个block不然yield 会报错
end

def cc(&b)
  ## 在调用cc 时必须根一个block不然b.call 会报错
  b.call  if block_given?
end

##EE block_given? 询问当前方法是否包含block

##EE & 的其他作用
# &obj == obj.to_proc 方法
["1", "2", "3"].map(&:to_i) 等价与
["1", "2", "3"].map {|i| i.to_i}

# 在 || 之内的变量成为块变量
# Block 本身不是对象


#把Block 变为对象
#有三种方法
#a = Proc.new <Block>
# 创建一个Proc 对象,把Block 作为参数传递进去
# 后可以调用a.call(args) 调用, 使用Proc.new 创建的变量在调用.call时不会检测
# 参数个数是否匹配
#
#
#b = lambda <Block>
#  b.call
#  
##EE lambda 还有一种写法
#b = ->(args) { }
#可以使用[3] 来代替 .call(3)
#e.g.
# - x {x*2}[3]
#
#c = proc <Block>
#  b.call
# lambda 和 Proc.new/proc 的区别在于返回的时候
# e.g.
begin
  lambad {return 1}.call ## 这里就是简单的从lambad中返回
end
begin
  proc {return 1}.call ## 这里是从包含proc的block上线文中返回,也就是直接从begin/end返回了
  123
end
# lambda 和 proc 都是Proc 对象


## 在ruby中高阶函数基本使用block，作为参数，
#而不是函数, 因为函数很难传递,调用方法也不统一
#
 #把普通方法，lamdb,proc转换为block, 就在前面添加&
如果是非block的高阶函数则，调用为.call,而不是括号

 def(method, x, y)
  method.call(x,y) * 2
  endfn

##EE load require 加载其他文件
# 每次调用load 都会加载并执行加载的文件
# require 则只会加载一次
# 通常返回false, 表示以及被加载了

# EE 
# BEGIN {
# }
#
# END{
# }
# 
# at_exit {
# }
#
#
#define?
#
#EE method_missing
#  一个回调函数，在调用不存在函数时调用
#  可以给一个class 定义自己的实例method_missing, 和类方法


## EE 常量
所有以大写字母开头的名字都是常量, Class, 模块名都是常量
常量是可以别改变的，不过会有警告出现
常量和变量有不同的scope规则.


## Kernel 模块
* Kernel 模块mix-in 在Objec
* 每一个对象都继承了Kernel的所有方法，因为都简介继承Object
* Kernel模块中的方法都可以直接使用,而不需要指定接受者，接受者为self(当前上下文)
* 所有在Kenrel 中的函数都可以作为'全局函数'




## Method 模块提供了针对一个方法的自省功能
  method(:puts).receiver 方法的接受者
  method(:puts).owner 定义的地方
  
  

## Ruby 对象模型
#Ruby世界的１为对象．只有对象

### 内置类型对象(类型)
NilClass -> nil -> 函数
Class


### Ruby 类继承关系
BasicObject
  Object
    Module
       Class
    NilClass
    CustemClass 所有没有显式父类的Class 对象都隐士继承Object

子类会继承父类的所有实例方法

### 每一个对象都有一个构造对象也就是.class
    这种关系并不是继承关系,继承使用.superclass看
    所有自定义模块都是Module 的实例


## ancestros 祖先连
    调用函数的查找方式，首先得到.class 查找实例方法，然后在父类上招


## meta programming 
#动态元编程 在运行期间执行

obj.instance_variables 所有的实例对象
obj.class
obj.methods 所有的方法
obj.public_methods
obj.ancestors 祖先chain

动态派发
obj.send(:method, args) 调用方法
 1.to_s == 1.send(:to_s)
   可以调用private
obj.public_send 只能调用共有方法

动态定义方法
obj.define_method() 参数是方法名

a= 123
MyClass = Class.new do
  #a 是可见的
  define_method :show do
    puts a
  end
end

obj.method_missing
  当找不到调用方法时调用，usage like erlang _ match
  e.g.
class XX
  def method_missing(id, *args, &block)
    retuen as($1.to_sym, args, block) if id.to_s =~ /^to_(.*)/) # S1 是一个全局变量，保存正则匹配的内容
    super #super.method_missing

  end
end

重写 method_missing 时要重写 obj.respond_to? 方法
保持一直

* ObjectSpace
ObjectSpace.each_oject(<className>).count


## const常量的自省方法有
Object.const_get("ClassName") -> Object 通过名字返回对应的对象
Object.const_set("Name", obj) 绑定对象与常量 
Object.constants() 返回当前模块定义的所有常量
Object.const_define?("cc")
Object.const_missing('Name')  回调函数在访问不存在常量时被触发, const_get的不到时也会触发
   返回值会被作为const_get的返回值

删除方法，通常用来确保某些方法不存在，调用method_missing
obj.undef_method 会删除所有方法，包括继承来的
obj.remove_method 只会删除调用对象自己的


Kernel.local_variables
Kernel.global_variables


scope def, class, module 进入这些作用域后，外边的*非常量*都是不可见的了
使用block来得到嵌套的作用域


Class 的对象都有
class_eval 一般用来给一个class添加方法
class_exec(arg) 和class_eval 相同只不过可以穿参

Object#instance_eval
在一个对象上下文中执行一个block
obj.instance_eval do
  puts @xx 
end

like instance_eval 但是可以传入参数
obj.instance_exec(3) do |x|
  baba
end

block 不是对象，如果需要存储block需要使用Proc,
  他会把block转换为一个obj
inc = Proc.new do |x|
  x+1
end
inc.call(3)


##dup clone
#dup(3) dum(obj)
#都返回一个浅拷贝
#
#如果拷贝对象类型定义了 initialize_copy (ruby 的拷贝构造,在dup时触发调用)
#
##EE taint 污染对象
#obj.taint
#obj.taint?
#作用??
#

当前类
当以类作为参数时
Module@class_eval
获得当前类
def add_method_to(a_class)
  a_class.class_eval do
    def m xxx end
  end
end

和class 重写打开类相同，但是class 只能用于常量，并且会打开一个新
作用域

## Singleton Methods
#单例方法， 就是只有一个特别的instance 有这个method，其他的相同class的instance都没有
#主要用来处理一些特殊情况，而不需要给class添加方法 
#e.g. title = "hello"
#      def title.upcase?
#         self.upcase == self
#      end

所有的类方法，都是这个类对象的单件方法

## Class macro

#eigenclass 单件类


### Gem about
RubyGems 是一个程序或库的标准化打包，安装框架。 类似于npm
主要提供
1. 标准化的包格式
2. 安装和管理相同库的不同版本
3. 查询，卸载包, 自动分析依赖

# 查询gems 存放的目录
# gem environment gemdir
#  /home/god/.rvm/gems/ruby-2.1.4
#  
#
#  每个都有一个 <GemName>.gemspec 文件，用于定义gem
#  
创建gem
1. 把所有的源文件都放在lib目录下
2. 包含一个lib/<GemName>.rb 的文件, 用来加载自己的gem
3. always has a README file use RDoc 
4. test/
5. C code in ext/
6. create a gem specification file <GemName>.gemspec
    format is yaml or Ruby code

Gem::Specification.new do |spec|
  spec.name          = 'nenv'
  spec.version       = Nenv::VERSION
  spec.authors       = ['Cezary Baginski']
  spec.email         = ['cezary@chronomantic.net']
  spec.summary       = "Convenience wrapper for Ruby's ENV"
  spec.description   = 'Using ENV is like using raw SQL statements in your code. We all know how that ends...'
  spec.homepage      = 'https://github.com/e2/nenv'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    /^(?:\.rspec|\.rubocop.*\.yml|\.travis\.yml|Rakefile|Guardfile|Gemfile|spec\/.*)$/.match(f)
  end

  spec.executables   = spec.files.grep(/^bin\//) { |f| File.basename(f) }
  spec.test_files    = []
  spec.require_paths = ['lib']

  ## this gem dependency
  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rspec', '~> 3.1'
  spec.add_development_dependency 'rake', '~> 10.0'
end

生成gem
gem build <Gemname>.gemspec
gem 文件是一个tar格式文件

## 有用的gmes
#EE gem install awesome_print 
#   like pp

## delegate
#
### regx 支持uncode
# 匹配后使用 $1 ... $n 来获得匹配的结果
# e.g. "12:434 =~ /(\d+):(\d+)/
#
# 删除一个字符串中指定的字符 a,b,c,d 
# "fejksofjef" =~ /([^a,b,c,d]+)/
# 

##EE Lex/Yacc
*Treetop ruby 的lex + Yacc

* Racc 一个ruby的Yacc 标准库中包含的

## 语法分析工具
#Ripper
#require 'ripper' 显示Ruby token
#code = <<EOF 
# 10 + 3
#EOF
#Ripper.lex(code)
#
#Ripper.sexp(code) 显示AST


## JSON
#a = [1,2,3,4]
#to json  b = a.to_json
# 
# to list
# c = JSON.parse(b)
#

## Time Date
a= Time.new # date + time
Time.now #same as Time.now

# string -> obj
Time.local(2001,2,15,20)
a.day
a.year

a.localtime #输出本地时间
a.utc #输出utc时间
a.strftime("%Y-%m-%d") #时间格式化
a.between?(i, j) # 测试a是否在i,j之间


## Rails
d = Date::new(2010, 2, 23)
Date::today
## string -> obj
"2002-1-22".to_date
"2002-1-22".to_datetime

## Logger
require 'logger'

  Log = Logger.new(STDOUT)
  #设置打印格式
  Log.formatter = proc { |severity, datetime, progname, msg|
    "#{severity} #{caller[4]} #{msg}\n"
  }

  Log.info "test message"
  Log.debug "test message"


## signal
## 信号处理 ruby 使用trap 方法捕获并处理一个信号
trap("TERM") { puts "TERM"}

## Web
#开启一个服务器 指定root/Dir
#ruby -run -e httpd . -p 3000

## Enumerable 模块
提供了大量的接口，如果一个class需要枚举能力．
则只需要include Enumerable
实现each方法 在each方法中调用 yield <elem>
Enumerable 所有的函数都依赖与each方法
如果在调用Enumerable的方法的时候不提供block则返回一个枚举器（迭代器) Enumerator

## Nil try 在一个可能是nil的对象上调用方法
# obj && obj.m1 && obj.m1.m2
# Rails 中可以使用try
#  obj.try(:m1)
# ruby 2.3.0以后增加了
# Safe Vavigation Operator  "&." 
# obj&.m1&.m2
# 

