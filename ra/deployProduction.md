## Rails 生成环境搭建与部署


## １为生成环境生成前端资源
* rake assets:precompile
* 生成密钥 生成secret_key
  rake secret RAILS_ENV=production
  把生成的key export 到环境变量中,也可直接放在 config/secrets.yml中
  production:  
    secret_key_base: <%= ENV["SECRET_KEY_BASE"] %>  

## 2初始化好DB
DB 需要在运行rails 前初始化好
　　rake db:setup RAILS_ENV=production

## 3 部署Nginx
 开启静态资源代理,和upstream 想app 发起请求
 配置 nginx.conf
 see ../puma.readme


##4 puma 部署
  新建　config/puma.rb
 see ../puma.readme


##5 启动应用
rails s -e production 指定启动模式
启动生成模式后所有的静态资源在public中，但是app本身不进行处理，需要使用其他反向代理，
比如nginx

如果需要让rails能够处理静态文件则配置
config.public_file_server.enabled = true



### 部署 deploy
gem mina
1. 首先 mina init
 会生成config/deploy.rb 配置

2. 修改配置 
3. mina setup --verbose
    初始化远程主机环境
执行完后，需要手动编辑shared 中的配置，因为每回都会用这个重写当前项目对应的文件


每次部署
4. 提交代码到git 仓库
5. mina deploy
   
注意环境的配置，
需要使用rvm, 要不然找不到bundel
需要安装nodejs 不然报错
发布的时候自动就是produce 环境
注意如果在配置文件中写错指令， 则不会报错，直接忽略



