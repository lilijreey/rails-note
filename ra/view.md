## Rails view 实战指南


## 表单辅助
label
text_field
text_area
password_field(:login, :pass, size: 20)
radio_button
check_box
file_field
select
select_date
select_datetime
hidden_field
submit


hidden_field_tag(name, value = nil, options = {})

### link helper  指定后缀格式

students_path(format:'json')

###link_to
* 内嵌html ele
    = link_to raw("<span> aaa</span>") , lessons_path(:ban_course_id => bc.id)

* 确认
   = link_to "Visit Other Site", "http://www.rubyonrails.org/", data: { confirm: "Are you sure?" }


* 穿参数  link_to "Nonsense search", searches_path(foo: "bar", baz: "quux")
   # <a href="/searches?foo=bar&amp;baz=quux">Nonsense search</a>

* 指定后缀类型
    = link_to "xxx csv", xxx_path(xx, :csv);
      <a href="/xxx.csv"></a>

* onclick
  不应该直接在link_to 设置onclick 而是使用Jquery
  $('a.item-box').click (e) ->
    console.log('onclick')


## button_to
生成一个form,默认方法为POST

### Layout
默认有一个application
不要使用,

给每一个controller 都指定layout,
如果不指定，默认使用和控制器同名的layout文件(如果有的化)
如果没有使用Application

class XXController
  layout 'ooo'
end


### render

* = render  @content 
 其实会翻译为
 ```
   render paritial: 'content.class/content', locals:{content.name: @content}
   也就是说,部分渲染,中可以访问的变量名与传入的变量名不一定相同

<%= render partial: "account", object: @buyer, as: 'user' %>

render :file => 'public/404.html', layout: false, status: "404"
```

* 一个controller 中只能执行一次render,
  如果有分支, 则必须使用return 显示返回
    e.g.   return render :signup_new

### 头像
生成github-lile 头像
gem identicon

```
直接生成内联图片,默认的大小为125x125太大了
= image_tag(Identicon.data_url_for(s.phone))

= image_tag(Identicon.data_url_for('xxx oo', 128, [255,255,255]
```

## flash

flash.now.alert = "Beware now!"
flash.now[:alert] = "Beware now!"

flash.now.notice = "Good luck now!"
flash.now[:notice] = "Good luck now!"





## Ajax
所有的send 都可以使用ajax 的方式
这是发声的HTTP请求 Accept 会变为 
   */*;q=0.5, text/javascript, application/javascript, application/ecmascript, application/x-ecmascript
server 端受到后会匹配到js 中
# send a Ajax req
#   add remote: true
#   e.g.  <%= button_to 'Add to Cart', line_items_path(product_id: product), 
#           remote: true %>
#

Rails 内建使用js的方式为 UJS
Rails　中处理ajax 返回的三种方式

1.第一种方式
手动使用ajax

<%= link_to 'Hello!', welcome_say_hello_path, :id => "ajax-load"  %>

<div id="content">
</div>

<script>
$('#ajax-load').click( function(e){
  e.preventDefault();
  var url =  $(this).attr("href");
  $.ajax(url, {
    success: function(response) {
      $("#content").html(response);
    }
  });
</script>

## 第二种方式
使用 javascript 脚本
后台渲染


## 第三中方式　返回json

## 添加event handler
<script>
$(document).ready(function() {
    $('.ajax_update').on("ajax:success", function(event, data) {
        var event_area = $('#event_area');
        event_area.html( data.name ); //data是后台返回的数据
    });
});
</script>

respond_to do |format|
  format.js { render :json => @user.to_json}
end

还可以使用JSONP

## 



#server  需要formts.js {xxxxx}
# 因为Ajax 默认的dataType 是script

Rails 的Ajax 一般分为json 和js
js , 是后台返回一个js code, 就是在成功后操作的code, 
    这种叫做服务端Ajax

e.g.
#= link_to 'new comment', new_book_comment_path(@book, :format => :js),
#  :remote => true, :id => 'new_comment_link'
#     这个请求会导致调用 view/comments/new.js.xxx template
#     
#  new.js.erb << 
#    $("<%= escape_javascript render(file: 'comments/new.html.haml') %>").insertAfter('#comments');
#    $('#new_comment_link').hide();
#  EOF


halper 
j() == escape_javascript()

json,后台只会返回一个json 数据, 
    只用json 时要加上　"data-type" => :json

button_to , link_to, form_to 如果加上 remote => true 都会变为Ajax 提交
