## Rails 路由

### 同一URL根据不同状态路由到不同controller#action
使用　constraints
~~~ruby
constraints(TeacherConstrainer.new) do
  namespace :teacher do
    resource :dashboard ## 同一个资源
  end
end
constraints(StudentConstrainer.new) do
  namespace :student do
    resource :dashboard ## 同一个资源
  end
end

class TeacherConstrainer ## 需要实现matches?　方法
  def matches?(request)
    # 首先需要确定是不是已经登录了
    return false unless request.env["warden"].authenticate?

    user = request.env["warden"].user

    # 自定义逻辑来确定用户是不是Teacher, eg: Rolify
    user.has_role? :teacher
  end
end

class StudentConstrainer
  def matches?(request)
    # 首先需要确定是不是已经登录了
    return false unless request.env["warden"].authenticate?

    user = request.env["warden"].user

    # 自定义逻辑来确定用户是不是Student, eg: Rolify
    user.has_role? :student
  end
end
~~~


e.g. 
~~~ruby
get ':controller/show/:id' => show, id /\d+/
get ':controller/show/:id' => show_error
~~~ruby

* contraints 一般用来对URL的参数做检测

* contraints 的参数也可以是一个obj, 参数是requist
~~~ruby
get 'records/:id' => "records#protected",
  constraints: proc {|req| req.params[:id].to_i < 100 }
~~~

