class TwilioController < ApplicationController
  @@default_client = "+815031877665"
  def index
    # アカウント情報の設定
    @account_sid = ENV['TWILIO_ACCOUNT_SID']
    @auth_token = ENV['TWILIO_AUTH_TOKEN']
    # twilioの電話番号コンソールからTwiMLAppsを作成した際に生成されるtoken
    #demo_app_sid = 'AP46efc07acdb746981abfe0ce7495550a'
    demo_app_sid = ENV['TWIML_APPLICATION_SID']
    capability = Twilio::Util::Capability.new @account_sid, @auth_token
    capability.allow_client_outgoing "EH5e80a548e5a0c563e9526ae39ddaea29"
    capability.allow_client_incoming "jenny"
    #capability.allow_client_outgoing demo_app_sid
    @token = capability.generate
  end

  def call
    @title = "ブラウザフォン"
    # アカウント情報の設定
    @account_sid = ENV['TWILIO_ACCOUNT_SID']
    @auth_token = ENV['TWILIO_AUTH_TOKEN']
    #@account_sid = 'ACbb3b3a4ad8cf20d7d1c8720c580afd0c'
    #@auth_token = 'c5983506e5ca100971a7642764b4c9d9'
    capability = Twilio::Util::Capability.new @account_sid, @auth_token
    # TwiMLAppsのSIDです
    capability.allow_client_outgoing "AP223ea4fc3c9070a767f4bc310749ebcd"
    capability.allow_client_incoming @@default_client
    @token = capability.generate
  end
  
  # twilioからのリクエスト受信用
  def dial
    response = Twilio::TwiML::Response.new do |r|
      # Should be your Twilio Number or a verified Caller ID
      r.Dial :callerId => '+815031877665' do |d|
        d.Client 'jenny'
      end
    end
    response.text
  end
end
