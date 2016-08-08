require "pry"
class Anagram
  def self.are_anagram(a,b)
    return "Enter Valid String" if (a.nil? || b.nil?)
    is_anagram = false
    is_anagram = true if a.chars.sort.join == b.chars.sort.join
    return is_anagram
  end
end

puts Anagram.are_anagram("momdad","dadmom");
puts Anagram.are_anagram("orchestra","carthorse");