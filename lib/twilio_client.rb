class TwilioClient
  def self.available_phone_numbers(area_code)
    new.available_phone_numbers(area_code)
  end

  def self.purchase_phone_number(phone_number)
    new.purchase_phone_number(phone_number)
  end

  def initialize
    account_sid = ENV['TWILIO_ACCOUNT_SID']
    auth_token  = ENV['TWILIO_AUTH_TOKEN']
    @sms_number = ENV['SMS_NUMBER']
    @client = Twilio::REST::Client.new account_sid, auth_token
  end

  # 利用可能電話番(050)号検索
  def available_phone_numbers()
    @client.available_phone_numbers.get('JP').local.list().take(10)
  end

  def purchase_phone_number(phone_number)
    # TwiML Apps
    application_sid = ENV['TWIML_APPLICATION_SID'] || sid
    @client.incoming_phone_numbers.
      create(phone_number: phone_number, voice_application_sid: application_sid)
  end

  # SMS送信
  def send_message(phone_number,message)
    @client.account.messages.create({
      :from => "#{@sms_number}",
      :to   => "#{phone_number}",
      :body => "#{message}",
    })
  end

  private

  DEFAULT_APPLICATION_NAME = 'Call tracking app'

  def sid
    applications = @client.account.applications.list(friendly_name: DEFAULT_APPLICATION_NAME)
    if applications.any?
      applications.first.sid
    else
      @client.account.applications.create(friendly_name: DEFAULT_APPLICATION_NAME).sid
    end
  end

  attr_reader :client
end
