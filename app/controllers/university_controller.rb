class UniversityController < ApplicationController
  def index
    params[:page] = params[:page] || 1
    @data = File.read(Rails.configuration.data_dir.join("university_record.json")) rescue nil
    if @data
      @records = Kaminari.paginate_array(JSON.parse(@data)["data"]).page(params[:page]).per(10)
    end
  end
end
