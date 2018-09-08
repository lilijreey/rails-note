### ActiveRecord 使用

Qus
######
* after_initialize



###验证函数
默认的一个AD在保存到DB前都会自动调用，检测函数，如果不满足条件
则不会保存

* validates
* validate
* validates_each

在罗辑层面验证，而不是DB层面
###### 参数 
* if fnObj
  接受一个谓词函数做检测
* unless fnObj
  接受一个谓词函数做检测,和if相反
* uniqueness
* presence
* length:{within: 0..255}

  

~~~ruby
  validates :user_id, uniqueness: { message: 'has already been reported' }


  validates :session_expire_delay,
            presence: true,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }


  //url
  validates :home_page_url,
            allow_blank: true,
            url: true,
            if: :home_page_url_column_exist


  //email
  validates :admin_notification_email,
            email: true,
            allow_blank: true


  //包含在
  validates :enabled_git_access_protocol,
            inclusion: { in: %w(ssh http), allow_blank: true, allow_nil: true }

  //排除
  validates :username, exclusion: { in: %w(admin superuser) }

  //长度
  validates :first_name, length: { maximum: 30 }

  //唯一
  validates :deploy_key_id, uniqueness: { scope: [:project_id], message: "already exists in project" }


  //unless
  validates :project, presence: true, unless: Proc.new { |service| service.template? }


  validates_each :restricted_visibility_levels do |record, attr, value|
    unless value.nil?
      value.each do |level|
        unless Gitlab::VisibilityLevel.options.has_value?(level)
          record.errors.add(attr, "'#{level}' is not a valid visibility level")
        end
      end
    end
  end
~~~


#### 钩子函数
* before_validate
* before_save?
* after_create



## rails dbconsole
  进入db 控制台

API
+ XX.column_names
+ XX.new -> object()
+ XX.create == XX.new + obj.save
+ XX.first 具体是哪个要看排序的顺序
+ XX.last  反方向排序的first
+ XX.all
    如果先让返回按某个字段排序
    default_scope lambda { order('categories.name')}
      相当于编程　all.order('xxxx')
+ XX.find_by_FieldName 只会返回第一个匹配的,如果要返回多个使用where
+ XX.count
+ XX.count_by_sql
+ XX.delete(Id) 也是删除,只不过不需要先find 在调用 destroy
   不会加载data
  DELETE FROM Tab WHERE Key=(Id)
   返回删除的个数
+ xx.find_by_sql("select * from xxx") 使用SQL语句查询
+ XX.select(:fieldName1, :fieldName2) 等于是XX.all 然后只返回你指定的fieldName
      用来过滤希望返回的信息
       e.g. XX.where(xxxxx).select(yyyy)
+ XX.where(:title => 'RailsConf')
+ XX.where(:title == [arg1,arg2])
+ XX.limit
+ XX.offset 必须和limit一同使用，制定跳过的返回结果的个数
+ XX.exists?
+ XX.uniq
+ XX.arel_table 得到一段查询语句生成的SQL
   e.g.
     u = User.arel_table
     u.where(u[:login].eq("mack")).to_sql

+ XX.destroy  先find在delete
    find(id).destroy
     返回[obj,..] 如果找不到就会产生异常

+ connection
  ActiveRecord::Base.conection

+ obj.valid? 验证有效性，使用model定义的验证函数
    重写valid相关方法
+ obj.new_record?
+ obj.persisted?
+ obj.attributes 返回所有属性的集合Hash
+ obj.save -> bool()
+ obj.save! 抛出异常 和save相同
+ obj.update(Hash) -> bool 编辑和save 一起完成
+ obj.update_attribute(Key,Value) -> bool 编辑和save 一起完成
+ obj.destroy 
+ obj.find(Id) return ???
+ obj.reload.FieldName overcover new value use db value
+ obj.dup 自动生成一个新的对象,除了id, created_at 为nil外,其他和源对象一样

+ obj.errors 如果上一个操作执行失败,失败的原因会写入errors
  
has_many XXX 会自动导出
   obj.xxxs
   obj.xxxs=
   obj.xxxs << 
   obj.xxxs.delete
   obj.xxxs.empty?
   obj.xxxs.size
   obj.xxxs.ids -> list(id)
   obj.xxxs.clear 设置对应的xxx 的foreign_key null
   obj.xxxs.find
   obj.xxxs.build
   obj.xxxs.create


belong_to YY 会导出
obj.yy
obj.yy.try(:name) 检测nil

has_one XX 会自动导出
 obj.XX
 obj.XX=
 obj.XX.nil?
 obj.build_XX(Hash)
 obj.create_XX(Hash)

has_one :course, :through => :course_node
  可以用来自动导出三张表的join查询
  +--+               +--+              +--+
  | a| belongs_to -> | b| belongs_to-> | c|
  +--+               +--+              +--+

  那么如果要从c来查找a,需要两次select c.b.a.attr
  这时可以　在c中声明　has_one a :throught => b
  然后就可以　c.a.attr 使用一次查询

has_one belongs_to 区别
 区别很小,belongs_to 是我有你
 has_one 是你有我
 ~~~ruby
    class Person < ActiveRecord::Base
      has_one :cell # the cell table has a person_id
    end

    class Person < ActiveRecord::Base
      belongs_to :cell # the Person table has a call_id
    end
  ~~~


###代理
当有belongs_to :user 时
需要在当前obj, 访问对应user.name 可以使用 delegate 

~~~ruby
  delegate :name, to: :user, allow_nil: true, prefix: true
~~~
*  prefix 选项用来控制导出的函数
  prefix 为true 导出的函数是有一个前缀的　obj.user_name
  prefix =>"xxx"
  导出为obj.xxx_name

* allow_nil 选项来，指定关联的对象是否可能为nil

###属性别名
* alias_attribute(new_name, old_name)
* alias_attribute?



#### enum
Declare an enum attribute where the values map to integers in the database,
but can be queried by name.
~~~ruby
enum sex: [:male, :famale]
~~~
在 DB层面
t.integer :sex, default:0

### migrate
* index
t.bigint :phone, index:true
t.bigint :phone, index:{unique:true}
t.index :name, unique:true


    create_table :students do |t|
      t.string :name, null:false, defalut:""
      t.jsonb :info, null:false, default: {}
      t.references :ban, :type => :string, #默认可以为nil
      t.references :role, default: Role::STUDENT

      #t.timestamps
    end
    add_index :students, :info, using: :gin
  end
