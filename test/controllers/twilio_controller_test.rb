$:.unshift File.dirname(__FILE__)  # ロードパスにカレントディレクトリを追加
require 'test_helper'

class TwilioControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get twilio_index_url
    assert_response :success
  end

end
