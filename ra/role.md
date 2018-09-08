## 权限系统设计

只对系统的入口做权限控制,也就是action


* 资源
* 对资源操作 


role_table 存储一个role对所有资源操作的权限,


* 同一用户,不同状态权限实现, 不同状态切换不同角色


role 角色:一组权限的集合
   资源对应Raise 中的controller (其实是路由上的resource)


* root 实现, 内置root角色

* 自动得到操作
* 得到一个controller 中的所有 action 
   BooksController.action_methods

* 得到所有 controller 
  ApplicationController.descendants
   这个只能返回已经被加载的controller
  

