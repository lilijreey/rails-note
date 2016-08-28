## Ruby 从1.9开始有了系统级线程 ,之前都是green-thread,应用线程
#由于有GIL(Global interpreter Lock) 的存在 MRI Ruby多线程并不能利用多核
#
#当一个线程在等待IO时其他线程可以被执行
#
#Qus 为何会有GIL?
#  GIL: is a mechanism used in computer language interpreters to synchronize the execution of threads so that only one native thread can execute at a time
#  确保即使在多核系统上,同一时刻也只有一个系统线程在执行
#  GIL 是一个互斥锁被解释器持有,用来避免非线程安全的代码被同时执行,害怕捅娄子
#  本质上GIL的功能就是限制多个线程同时执行一个VM中的代码,因为要后兼容
#
#  为何java虚拟机没有GIL
#
#  VM 和 thread的关系
#
#  GIL 是一个权宜之策,因为大部分的ruby库都不是线程安全的. 这样就需要大量的锁,会很慢, 有点像Erlang, 的点进程模式和SMP模式
#  GIL 用来保护C代码级别的原子调用


def worker1
  puts "worker 1 doing.."
  sleep(3)
end

def worker2
  puts "worker 2 doing.."
  sleep(2)
end

def worker3
  puts "worker 3 doing.."
  sleep(5)
end

##EE create  线程创建后会自动执行
# Thread.new { code }
# Thread.start
# Thread.fork

## EE Thread.current 返回当前线程对象
#     Thread.main 返回主线程对象
threads = []
threads << Thread.new { worker1}
threads << Thread.new { worker2}
threads << Thread.new { worker3}

## obj.join 等待对应线程结束
threads.each { |t| t.join }
