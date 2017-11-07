require 'test_helper'

class FileControllerTest < ActionDispatch::IntegrationTest
  test "should get get" do
    get file_get_url
    assert_response :success
  end

end
