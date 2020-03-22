require 'test_helper'

class LecturesControllerTest < ActionDispatch::IntegrationTest
  
  test 'should get to lecture_list' do
    get lecture_list_path
    assert_response :success
  end
  
end
