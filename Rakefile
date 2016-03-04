## rake ruby's Make
#Makefile 里面写的是shell, Rake里面写的是ruby
#
##EE install
#gem install rake
#
##EE 
#用于任务定义
## 首先所有的Rake任务都写在 Rakefile 中
task :default => [:test] ## 默认是default 任务,依赖test
                         ## 可以依赖多个目标,写在array中


## 定义一个test 任务do 里面的代码会在rake test 的时候执行
#rake test 执行
task :test do
  puts "run test"
end

##EE 可以为一个任务写描述 使用rake -T 显示
desc '创建系统'
task :build do
  puts "run build"
end

##EE File Task
#在依赖文件时使用,比如xx.csv 产生 xx.json
file 'json' => 'xx.csv' do
  puts "run json"
end

##可以在Rake中使用的工具函数
#mv
#mkdir
#touch 
#rm_rf

task :tool do
  FileList['*.rb'].each {|file| puts file}
end



