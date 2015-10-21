#Ruby
#一种基于完全OO 设计的语言

#
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
# gem source
# change gem source
#
# gem install <GemName> --rdoc
# gem install <GemName> --ri
# 
# 使用rvm 必须以一个login shell 登陆
# 
# gem environment 
#   查看环境
#   
# 查询gems 存放的目录
# gem enviroment gemdir
#
####ruby 安装完后安装rails
#gem install rails
#跟新gem 源 
# gem sources --help
#  gem sources -l
#  删除gemruby.org sources --remove
#  添加　gem sources -a http:ruby.taobao.org
#  清除cache gem sources gem sources -c
#  跟新　gem sources -u
#  
# bundle 有自己的源
# 也需要更新为阿里的 
# 
# bundle config 
# $ bundle config mirror.https://rubygems.org https://ruby.taobao.org
#
#国内镜像:
# 山东大学 'http://ruby.sdutlinux.org/'
#
#  
# 更改gemfile
# 

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

rtags
生成　tags 的工具
 rtags -vi files

compile
-------------------------------------
TODO

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
# 
# 使用include 则可以将模块中的所有定义混入到当前命名空间中
# 将模块混入类中称为 Mix-in, 可以使得多个class 复用相同的代码
#  本质上是在class的祖先链中加入模块
# 
# 使用extern 替换include 后，只是模块中的方法都变为的类方法，而不是实例方法
# 
# 导出模块方法，　模块中定义的方法都只能在本模块内部使用，如果想
# 导出方法要使用　module_funciton :xxx
# 
# 作为　namespaces 使用
# 实现　mixin
# 
# 使用　Module.fn 调用方法
# 使用　Module::xxx 访问常量
# 


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

## block
#{ ..}
# do .. end
#所有的block 都可以跟在一个function 后面，如果function 调用的yield 就会调用一个次block
#deof cb
#  print one
#  yield(arg1, arg2)
#end
# cb {|arg1, arg2| xxx ;}

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
#所有以大写字母开头的名字都是常量, Class, 模块名都是常量
#常量是可以别改变的，不过会有警告出现

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
obj.define_method()

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

const_missing() 当对常量调用一个不存在的方法时

删除方法，通常用来确保某些方法不存在，调用method_missing
obj.undef_method 会删除所有方法，包括继承来的
obj.remove_method 只会删除调用对象自己的

EE 询问当前方法是否包含block
Kernel#block_given?

Kernel.local_variables
Kernel.global_variables


scope def, class, module 进入这些作用域后，外边的*非常量*都是不可见的了
使用block来得到嵌套的作用域

a= 123
MyClass = Class.new do
  #a 是可见的
  define_method :show do
    puts a
  end
end

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

## delegate
#
### regx 支持uncode
# 匹配后使用 $1 ... $n 来获得匹配的结果
# e.g. "12:434 =~ /(\d+):(\d+)/
#
# 删除一个字符串中指定的字符 a,b,c,d 
# "fejksofjef" =~ /([^a,b,c,d]+)/
# 


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
Time.local(2001,2,15,20)
a.day
a.year

a.localtime #输出本地时间
a.utc #输出utc时间
a.strftime("%Y-%m-%d") #时间格式化

d = Date::new(2010, 2, 23)
#
