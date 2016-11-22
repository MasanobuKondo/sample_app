class ConferenceController < ApplicationController
  def index
    @title = "V字通話作成"
  end
  # conference作成画面
  def create
    @phone1 = params[:phone_number1]
    @phone1[0,1] = "+81"
    @phone2 = params[:phone_number2]
    @phone2[0,1] = "+81"
    @account_sid = ENV['TWILIO_ACCOUNT_SID']
    @auth_token = ENV['TWILIO_AUTH_TOKEN']
    @number = ENV['TWILIO_NUMBER']
    @client = Twilio::REST::Client.new(@account_sid,@auth_token)
 
    # phone1 録音しない
    @call1 = @client.calls.create(
      to: "#{@phone1}",
      from: "#{@number}",
      url: ""
    )
    # phone2 録音する
    @call2 = @client.calls.create(
      to: "#{@phone2}",
      from: "#{@number}",
      url: ""
    )
  end
end
