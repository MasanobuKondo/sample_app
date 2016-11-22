module SampleHelper
  def twilist
    @account_sid = ENV['TWILIO_ACCOUNT_SID']
    @auth_token = ENV['TWILIO_AUTH_TOKEN']
    @client = Twilio::REST::Client.new(@account_sid, @auth_token)
    @nflag = false
    @client.account.calls.list({
      :status => "completed",
      :"start_time>" => "2016-09-01"}).each do |call|
      num1 = nil
      if call.parent_call_sid
        @parent = @client.account.calls.get(call.parent_call_sid)
        num1 = @parent.duration.to_i - call.duration.to_i
        content_tag(:td,"#{num1}")
        content_tag(:td,"#{@parent.start_time}")
        content_tag(:td,"#{@parent.from}")
        content_tag(:td,"#{@parent.to}")
        content_tag(:td,"#{@parent.duration}")
        nflag = true
        next
      end
      unless nflag
        next
      end
      nflag = false
    end
  end
end
