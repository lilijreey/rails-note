#pry
#install
#gem install pry
#gem install pry-doc #显示文档
#gem install pry-dyebug #dubugger 模块
#gem install pry-stack_explorer #显示堆栈信息

##config file
#~/.pryrc
#./.pryrc

## ruby pry.rb 进入调试
#调试cmd 
#p var 打印变量
#whereami 显示代码
#cd 切换上下文
#show-stack -v 显示堆栈
#up/down 在堆栈中移动
#reload-code 重新加载代码
#.<shell-cmd> 执行shell 命令
#
# step: Step execution into the next line or method. Takes an optional numeric argument to step multiple times.
# next: Step over to the next line within the same frame. Also takes an optional numeric argument to step multiple lines.
# finish: Execute until current stack frame returns.
# continue: Continue program execution and end the Pry session.
# up: Moves the stack frame up. Takes an optional numeric argument to move multiple frames.
# down: Moves the stack frame down. Takes an optional numeric argument to move multiple frames.
# frame: Moves to a specific frame. Called without arguments will show the current frame.
# break: 设置断点
#    break SomeClass#run            # Break at the start of `SomeClass#run`.
#    break Foo#bar if baz?          # Break at `Foo#bar` only if `baz?`.
#    break app/models/user.rb:15    # Break at line 15 in user.rb.
#    break 14                       # Break at line 14 in the current file.

#break --condition 4 x > 2      # Change condition on breakpoint #4 to 'x > 2'.
#break --condition 3         

#? method show doc
#  e.g. ? String#sub

##Special locals
#_ Result of last line
#_pry_ Local pry instance
#_ex_ Last exception
#_file_ current file
#_dir_ current dir


## 别名
Pry.commands.alias_command 'c', 'continue'
Pry.commands.alias_command 's', 'step'
Pry.commands.alias_command 'n', 'next'

##show-method 显示源码
require 'pry'

def aa()
  puts "aa"
  
end
puts "fefef"
a = [1,3,4]
binding.pry ##在需要打断点的地方写入binding.pry
a += [5,6,7]
aa()
puts "End"

