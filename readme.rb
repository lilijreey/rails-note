#Ruby
一种基于完全OO 设计的语言

#
# RVM 国内原
#sed -i -e 's/ftp\.ruby-lang\.org\/pub\/ruby/ruby\.taobao\.org\/mirrors\/ruby/g' ~/.rvm/config/db
#
#rvm install ruby
#
#rvm --default use Verison
#
# change gem source
# 
# 使用rvm 必须以一个login shell 登陆
# 
# insert rails
# 
# 更改gemfile
# 
#
# class 变量 和类实例变量
# @@xx 从属于class 对象(ruby 中一个class 也是一个对象)
 
# instance_of? 判断是不是某个类的实例
# is_a? 判断是不是继承过来的


class Point
  @@n = 0 ## 类变量，访问需要通过方法

  ## 在调用　Point.new 是会自动调用这个方法
  # 所有传递给new 的参数都会给initialize
  # new 方法是自动导出的
  def initialize(x,y) 
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

  ## attr_accessor :name
 
  class << self; attr_accessor :classObjVal end
  @classObjVal ## class level obj instance-varible
end
end

## access control 只对方法有效Now 


### Module
# Class 类是module 的子类, 类是一种特殊形式的module
# Root module 是 Kernel
# 使用module 的主要目的是，模块化代码
# 
# 模块没有实例
# 不能继承
#
# 以模块方式提供的方法必须使用 Module.func 来调用
# 引入模块　require 'xxx'
# 
# 使用include 则可以将模块中的所有定义混入到当前命名空间中
# 将模块混入类中称为 Mix-in, 可以使得多个class 复用相同的代码
# 
# 导出模块方法，　模块中定义的方法都只能在本模块内部使用，如果想
# 导出方法要使用　module_funciton :xxx


## 变量
# 1. 局部
# 2. 全局
#    以$开头
#    
# 3. 实例
#    以@开头
#    
# 4. 类变量
#   以@@开头

# 内置
# __FILE__
# __LINE__
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
