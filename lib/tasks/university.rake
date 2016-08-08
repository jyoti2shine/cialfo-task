require "pry"
namespace :university do
  desc "Scrap university data"
  task scrap_detail: :environment do
    url = "http://colleges.usnews.rankingsandreviews.com/best-colleges/rankings/national-universities/data"
    document = Nokogiri::HTML(open(url))
    page_count = document.css(".pager_dotdot+ .pager_link").text
    for i in 1..page_count.to_i
      doc_url = url + ("/page+#{i.to_s}")
      data_set  = Nokogiri::HTML(open(doc_url))
      data_set.css("tr[valign='top']").each do  |data|
        result_set = data.css("td")[0..6].each_with_index.map do |td,i|
          fetch_data(td,i)
        end
        print result_set
        puts ""
      end
    end
  end
end

def fetch_data(data,index)
  case index
    when 0
      data.css(".cluetip").text.strip
    when 1
      data.css("a").text.strip
    when 2..6
     data.text.strip
    else
      nil
  end
end