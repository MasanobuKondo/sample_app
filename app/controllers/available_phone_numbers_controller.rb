require 'twilio_client'
class AvailablePhoneNumbersController < ApplicationController
  def index
    area_code = params["area-code"]
    # TwilioClient is a thin wrapper for Twilio::REST::Client
    begin
      client = TwilioClient.new
      @phone_numbers = client.available_phone_numbers
    rescue SystemCallError => error
      STDR.puts error.message
    end
  end
end
