## Ruby 异常

Exception
### ruby异常全部继承与 Exception类

### 自定义异常
class MyException < Exception; end
class MyException < StandarError
  attr_reader :reason
  def initialize(reason)
    @reasion = reason
  end
end

begin
 code... 类似于C++try块
rescue Errno::XXX //类或者是子类都会匹配到

end

完整语法
begin
rescue Class => Var

else
    //没有异常发声时
ensure
   //有没有都会执行
end

+ rescue,else,ensure都是课选的
+ rescue
  的比较按照声明的顺序，一次匹配．只会匹配一次
+ retry 在rescue中使用，可以再从begin执行一次，如果还是有异常抛出，就会一直无限循环
+ ensure
  在跳出begin时一定会被执行，不管是用声明方式.(异常,return,break)



raise 抛出异常

rescue 捕获异常

ensure 类型与finial. 有没有异常都执行这里

##发生异常 raise
raise # 抛出一个RuntimeError
raise "msg" # 抛出一个RuntimeError 和指定的消息
raise Type, "msg"

raise 抛出的类型只能是,Exceptin 的子类
obj.message 得到消息
raise 和C++ throw类似，也是中断当前指令的执行，沿着调用栈向上抛出异常，直到有

## StandarError
 用来表示程序中的罗辑错误

### SystemCallError
 系统调用失败时生成
