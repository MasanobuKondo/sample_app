require 'test_helper'

class SampleControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get sample_show_url
    assert_response :success
  end

end
