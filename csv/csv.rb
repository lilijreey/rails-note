## CSV lib
#
#EE　指定分隔符
# option Hash :col_sep
# 
#EE 从制定行开始读
# csv.shift
#read

## EE header=true 如果设了这个选项
#则每个row 不是简单的array, 而是CSV::row 类型
# 可以使用　fieldName 来直接引用
# e.g. row["id"]
#
#to sqlite
#
#search

require 'csv'

#CSV.foreach("t.csv") do  |row|
#  ## row 是一个数组
#  f_id = 0
#  f_name =1
#  f_age = 2

#  #print row
#  print "id:#{row[f_id].to_i} name: #{row[f_name]} age: #{row[f_age].to_i}\n"
#end

## EE open
#CSV.new 返回一个csv 对象
## 注意open 返回时指示生成了一个对象还没有读文件
tab = CSV.open("tab.tsv", "r", col_sep: "\t", skip_lines:"#.*", headers: true) 

## 如何设置了headers 则会自动读第一行，　each 从第二行开始
## 读header
#print "header: #{header}\n"
tab.each() do |row|
  print row
  #print row["id"]
end

##EE 生成的查询接口，都有的
#1. lookup_row(key)
#2. lookup_field(key)
#3. is_exist(key)
#
#4. mate info
#
#附加可生成
#4. get_all_value(field) 
#5. group 概念，
#6. match_value 返回和制定值相同的所有的row
#
#自定义可生成接口
#TODO
class ConfigTab
  fileds "fjesfesf" do |t|
    t.int :id, id:true
    t.text :name, length: {max:16}, default:""
    t.uint_16 :age , value:{max: 323, min:-1212}
    t.reference :item_id ## reference 为这个表引用其他表的主键, 默认根据fieldName解析item 表
    t.reference :costId , table:cost
    t.reference_value :carrer, table:xxx, field:carrer ## 引用了一个表中一个filed 中的值
    t.atom :cmd
    ## [1,3,4,5,6]
    #{3,4,5}
    t.term :fesf, varify :fesf
  end

  input = "fjeosf"
  ## 选择输出的格式
  output :cient, "xxofef", files:[:d, :ame, :ge, :tem_id, :mad]
  output :server, "xxofef", files:[:d, :ame, :ge, :tem_id, :mad]
end

class ConfigTab
    @file ## 
    @server_output
    @client_output

    @fields
    @key_fields
    @varifys

    attr_reader :file, :server_output, :client_output, :fields, :key_fields 
end

## 所有的filed 都是fieldBase对象
class FieldBase
  @name
  @default_val
end

class IntField < FieldBase

end




#%% 商店配置结构
#-record(shop_cfg, {
#          id         = 0,  %% 售卖id（item_bid*1000+type
#          type       = 0,  %% 商店类型
#          item_bid   = 0,  %% 物品bid
#          money_type = 0,  %% 货币类型(10金币
#          price      = 0   %% 出售价格
#         }).
#     #config_meta{record=#shop_cfg{},
#                  fields = record_info(fields, shop_cfg),
#                  file="shop.txt",
#                  keypos=#shop_cfg.id,
#                  verify = fun verify/1 }


#class Post < ActiveRecord::Base
#  validates :title, presence: true, length: {minimum: 5}  
#  validates :body, presence: true

#  def change
#    create_table :posts do |t|
#      t.string :title
#      t.text :body

#      t.timestamps
#    end
#  end
#end
