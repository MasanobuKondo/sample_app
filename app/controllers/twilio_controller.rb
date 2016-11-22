class TwilioController < ApplicationController
  @@default_client = "+815031877665"
  def index
    # アカウント情報の設定
    @account_sid = ENV['TWILIO_ACCOUNT_SID']
    @auth_token = ENV['TWILIO_AUTH_TOKEN']
    # twilioの電話番号コンソールからTwiMLAppsを作成した際に生成されるtoken
    demo_app_sid = ENV['TWIML_APPLICATION_SID']
    capability = Twilio::Util::Capability.new @account_sid, @auth_token
    capability.allow_client_outgoing ""
    capability.allow_client_incoming ""
    @token = capability.generate
  end

  def call
    @title = "ブラウザフォン"
    # アカウント情報の設定
    @account_sid = ENV['TWILIO_ACCOUNT_SID']
    @auth_token = ENV['TWILIO_AUTH_TOKEN']
    capability = Twilio::Util::Capability.new @account_sid, @auth_token
    capability.allow_client_outgoing ""
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
