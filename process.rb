## process
#产生子进程的几种方式
#1. Kernel.system("ls")
#
def f1
#2. Kernel.fork
#  返回两次，分别在父进程中，和子进程中
  pid = fork

  if pid.nil?
    puts "child process"
  else
    puts "parent process cid: #{pid}"
  end 
  sleep 10
end

def f2
  ## 或者是fork 后门跟Block 会在子进程中执行Block, 
  fork do
    puts "aa"
    puts "child process #{$$}"
    sleep 3
    puts "child process over"
  end
  ## 父进程必须wait　子进程或者deattach
  #不进行wait 则会产生僵尸进程
  #Process.wait
  puts "parent process"
end
