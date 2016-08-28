## Rspec 行为驱动测试框架

### install
gem install rspec

### init rspec
rspec --init


### config
.rspec


### 写测试
所有的测试都在spec目录下

内建函数
* describe
   一个容器，用来包裹对一个模块的测试
* context
   context 和 describe 一样，只是语义不同
   一个容器，用来让不同的测试例子,在一个上下文中

* it 用来定义一个测试例子
* xit 用来临时性跳过某个测试
   不会执行这个测试，可以给it前加上x
   或者直接在it里面添加 pending
    

* expect(exp)
  * .to
  * .not_to

  expect(ss.isOk?).to be true
  expect { 1/0 }.to raise_error(ZeroDivisionError)
  expect { 1/0 }.to raise_error("divided by 0") 
  expect { 1/0 }.to raise_error("divided by 0", ZeroDivisionError) 

* before
  before(:each) do
  每次测试前执行
   ...
  end
  before(:all) 在所有开始之前执行，只会执行一次

* after(:each/:all)

### Matcher
* eql
* eq
* be
* equal
* be_between(a,b)

* be true
* be false
* be_nil
* be_truthy #当不为nil或false

* raise_error


### run test
rspec spec

### Tags
用来给测试添加标签，可以只测试具有特定标签的例子
it 'xxx', :slow => true do
end

没有显式添加 tag的测试用例，都默认为:focus

rspec --tag <RunTagName>




### File


