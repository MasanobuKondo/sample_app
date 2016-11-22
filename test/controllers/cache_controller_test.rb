require 'test_helper'

class CacheControllerTest < ActionDispatch::IntegrationTest
  test "should get test" do
    get cache_test_url
    assert_response :success
  end

end
