##抓取西安所有中小学 信息
##
##抓取网站: 西安市中小学信息公开平台 http://xalt2011.gotoip1.com/xa_schoolinfo/index.html
##
##学校info
##{ id,
## name,
## address,
## map_point, 
## phone,
## mail,
##email,
##学段: 高中，初中，完全中学
##性质: 民办，公办，
##隶属: xxx教育局
##区域: 碑林区...
##教师人数:
##icon： 学校图标
##学校照片:
##}
##

require 'net/http'
require 'nokogiri' ## HTML/XML 解析库, 可以用来在html中所搜
                  ## 提供xpath 和css 选择器两种 selector
# nokogiri 用法
# doc = Nokogiri::HTML(htmlString)
#  doc.css('合法的css选择器') -> 返回的是array(XML::Element)
#  e.g.
#   doc.css('h1').echo do |h1|
#     puts h1.content ## 打印<h1>XXXX </h1>中的xxx
#   end
#   
#   doc.css('table tr')[1].css('td') 多次查找
#   
#   属性查找
#   <h1 class="hh">XX</h1>
#   doc.css('h1')[0]['class']  == "hh"
#   直接使用hash写入需要的属性名即可



URI_BASE = "http://xalt2011.gotoip1.com/xa_schoolinfo/school-info/index.php?district_code=0&pageNum=%d"

def main()
  total = total_pages(get_page(1))
  data = (1..total).map {|i| parse_page(i)}
  save(data)
end

def get_page(num)
  url = sprintf(URI_BASE, num)
  resp = Net::HTTP.get_response(URI(url))
  if resp.code != "200"
    puts "http require #{url}\n failed"
  end
  doc = Nokogiri::HTML(resp.body)
end

## hash
def parse_page(num)
  doc = get_page(num)
  school_list = doc.css('ul.school-list li')

  data = []
  school_list.each do |l|
    s = {} 
    l['onmouseover'] =~ /([\d.]+),([\d.]+),([\d.]+)/ #xx(11.22,22.22,33.33)

    s['position'] = [$1.to_f, $2.to_f, $3.to_f]
    s['logo'] = l.css('.school-logo img').first['src']
    s['name'] = l.css('.school-info h3 span').first.content.strip
    s['addr'] = l.css('.school-info div span').first.content.strip
    info = l.css('.school-info p')
    s['phone']         = info[0].css('span').first.content.strip
    s['mail']          = info[1].css('span').first.content.strip
    s['study_type']    = info[2].css('span').first.content.strip ##学段
    s['attr']          = info[3].css('span').first.content.strip
    s['district']      = info[4].css('span').first.content.strip
    s['attach']        = info[5].css('span').first.content.strip ##隶属
    s['teacher_count'] = info[6].css('span').first.content.strip
    s['student_count'] = info[7].css('span').first.content.strip
    s['email']         = info[8].css('span').first.content.strip
    data << s
  end
  puts "parse page #{num} finish"
  return data
end

def total_pages(doc)
  doc.css('.page-num-wrap span').last.content =~ /(\d+)/
  $1.to_i
end


def save(data, file="data.json")
  f = File.new(file, "w")
  f.puts data.to_json
  f.close
end

