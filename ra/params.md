## params Rails 内置变量,用来存储一次请求的多有变量

params本身是一个有结构的hash

* require 取得一个参数
params.require(:user).permit(:name, :email, :password, :password_confirmation)

* permit 是取得制定参数,用来放置恶意攻击
