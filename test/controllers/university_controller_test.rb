require 'test_helper'

class UniversityControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get university_index_url
    assert_response :success
  end

end
