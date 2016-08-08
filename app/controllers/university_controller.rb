class UniversityController < ApplicationController
  def index
   @data = File.read(Rails.configuration.data_dir.join("university_record.json")) rescue nil
   if @data
     @records = JSON.parse(@data)
   end
  end
end
