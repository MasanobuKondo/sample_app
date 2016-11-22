class TwilioWrap
  def initialize
    account_sid = ENV['TWILIO_ACCOUNT_SID']
    auth_token = ENV['TWILIO_AUTH_TOKEN']
    @client = Twilio::REST::Client.new(account_sid, auth_token)
    @twilio_number = ENV['TWILIO_NUMBER']
    @url = ENV['TWIML_APP_URL']
    @sms = ENV['SMS_NUMBER']
  end

  # 通話ログ取得
  def get_call_log(status = "completed")
    target = Time.now
    target = target.yesterday.to_s[0,10]
    nflag = false
    acc = {}
    @list = []
    @client.account.calls.list({
      :status => "#{status}",
      #:"start_time>" => "#{target}"}).each do |call|
      :"start_time" => "2016-09-16"}).each do |call|
      if call.parent_call_sid
        parent = @client.account.calls.get(call.parent_call_sid)
        num1 = parent.duration.to_i - call.duration.to_i
        acc = set_params(parent,parent.duration,num1)
        @list << acc
        nflag = true
        next
      end
      unless nflag
        acc = set_params(call,0,call.duration)
        @list << acc
        next
      end
      nflag = false
    end
    @list
  end

  # to send SMS
  # bodyは全角70文字制限
  def send_sms(phone_number,body)
    @client.account.messages.create({
      from: "#{@sms}",
      to: "#{change_number(phone_number.dup)}",
      body: "#{body}",
    })
  end

  # 会議通話作成(二人だけ)
  # TODO:配列で受け取り、カンファレンスに追加出来るようにする
  def conference(params = {})
    list = ["#{params[:phone_number1]}","#{params[:phone_number2]}"]
    list.each do |number|
      call = @client.calls.create(
        to: "#{change_number(number)}",
        from: "#{@twilio_number}",
        url: "#{@url}"
      )
    end
  end

  private
  
  # +81を付加
  def change_number(param,prefix = "+81")
    param[0,1] = "#{prefix}"
    param
  end

  def set_params(params = {},duration1 = 0,duration2 = 0)
    {"start_time" => "#{params.start_time}","from" => "#{params.from}","to" => "#{params.to}","duration1" => "#{duration1}","duration2" => "#{duration2}"}
  end
end
