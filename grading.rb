require "pry"
require "date"
class ResultManagent
  def initialize
    puts "Enter the No of Result Set you have !!!"
    input = gets.chomp
    @count = Integer(input) rescue 0
    @maths = 0
    @english = 0
    @hindi = 0
    @results = Array.new
  end

  def fetch_data
    if @count > 0
      puts "You have #{@count} result Set , Press Enter to Continue ."
      puts "Enter the Result for Following Subjects followed by Space \nMaths English Hindi Date(dd-mm-yyyy)"
      while @results.count < @count  do
        data = gets.chomp
        puts "Invalid Data , Enter Again !!!" unless validate_data(data)
      end
    else
      puts "Enter a Valid Number."
    end
  end

  def display_result
    puts "Maths => #{@maths}"
    puts "English => #{@english}"
    puts "Hindi => #{@hindi}"
    puts "Sum of the Result is #{@maths+@english+@hindi}"
  end

  private

  def validate_data data
    data_count = data.split(" ").count == 4
    if data_count
      dat = data.split(" ").each_with_index.map do  |v,k |
        type = k==3 ? Date : Float
        parse_data v,type
      end
      if !dat.include?(nil)
        @results << dat
        @maths = dat[0] if @maths < dat[0]
        @english = dat[1] if @english < dat[1]
        @hindi = dat[2] if @hindi < dat[2]
        return true
      else
        return false
      end
    else
      return false
    end
  end

  def parse_data data,type
    if type == Float
      return Float(data) rescue nil
    elsif type == Date
      return Date.parse(data) rescue nil
    else
      return nil
    end
  end
end

rm = ResultManagent.new
rm.fetch_data
rm.display_result







	


