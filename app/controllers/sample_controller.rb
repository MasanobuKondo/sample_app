require "twilio_wrap"
class SampleController < ApplicationController
  def show
    @title = "トラッキングサンプル1"
    twilio = TwilioWrap.new()
    @list = twilio.get_call_log("completed")
  end

  def initialize
    @list = Array.new
  end
end
