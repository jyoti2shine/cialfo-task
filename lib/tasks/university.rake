require "pry"
namespace :university do
  desc "Scrap university data"
  task scrap_detail: :environment do
    url = "http://colleges.usnews.rankingsandreviews.com/best-colleges/rankings/national-universities/data"
    record_hash = {:data => []}
    document = Nokogiri::HTML(open(url))
    page_count = document.css(".pager_dotdot+ .pager_link").text
    for i in 1..page_count.to_i
      doc_url = url + ("/page+#{i.to_s}")
      puts "Fetching #{doc_url}"
      data_set  = Nokogiri::HTML(open(doc_url))
      data_set.css("tr[valign='top']").each do  |data|
        result_set = data.css("td")[0..6].each_with_index.map do |td,i|
          [ convert_index_to_name(i), fetch_data(td,i)]
        end
        record_hash[:data] << Hash[result_set]
      end
    end
    save_data_to_file(record_hash)
  end
end

def fetch_data(data,index)
  case index
    when 0
      data.css(".cluetip").text.strip
    when 1
      data.css("a").text.strip
    when 2..6
      data.text.strip.split("\n").first
    else
      nil
  end
end

def convert_index_to_name index
  case index
    when 0
      "rank"
    when 1
      "name"
    when 2
      "tuition_fees"
    when 3
      "total_enrollment"
    when 4
      "acceptance_rate"
    when 5
      "average_retention_rates"
    when 6
      "graduation_rate"
    else
      nil
  end
end

def save_data_to_file data
  File.open(Rails.configuration.data_dir.join("university_record.json"),"w+") do |file|
    file.write(data.to_json)
  end
end