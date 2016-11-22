class Tracking < ApplicationRecord
  def initialize
    @account_sid = ENV['TWILIO_ACCOUNT_SID']
    @auth_token = ENV['TWILIO_AUTH_TOKEN']
    @client = Twilio::REST::Client.new(@account_sid, @auth_token)
    @list = Array.new
    @acc = Hash.new
  end

  def get
    nflag = false
    @client.account.calls.list({
      :status => "completed",
      :"start_time" => "#{yesterday}"}).each do |call|
      if call.parent_call_sid
        @parent = @client.account.calls.get(call.parent_call_sid)
        num1 = @parent.duration.to_i - call.duration.to_i
        @acc = {:start_time => "#{@parent.start_time}",
                :from => "#{@parent.from}",
                :to => "#{@parent.to}",
                :duration1 => "#{@parent.duration}",
                :duration2 => "#{num1}"}
        self.create(@acc)
        nflag = true
        next
      end
      unless nflag
        @acc = {:start_time => "#{call.start_time}",:from => "#{call.from}",:to => "#{call.to}",:duration1 => "0",:duration2 => "#{call.duration}"}
        self.insert
        next
      end
      nflag = false
    end
  end

  def insert
  end

  def select
  end
end
