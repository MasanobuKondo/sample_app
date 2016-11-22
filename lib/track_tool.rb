class TrackTool
  def initialize
    account_sid = ENV['TWILIO_ACCOUNT_SID']
    auth_token  = ENV['TWILIO_AUTH_TOKEN']
    @client = Twilio::REST::Client.new account_sid, auth_token
  end

  # TODO:対象年月日の通話記録取得
  def get_calls_log(start_date)
    @client.account.calls.list.each do |call|
    
    end
  end
end
