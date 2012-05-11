require 'httparty'

class DefaultController < ApplicationController
  def home
    if access_token
      @profiles = HTTParty.get(profiles_url,
        :query => {:access_token => access_token}
      ).parsed_response
    end
  end

  def network
    @data = singly_call('linkedin', 'connections')
  end

private

  def singly_call(service, command)
    HTTParty.get(
      [SINGLY_API_BASE, 'services', service, command].join('/'),
      :query => {:access_token => access_token}
    ).parsed_response
 end

  def access_token
    session[:access_token]
  end

  SINGLY_API_BASE = "https://api.singly.com"

  def profiles_url
    "#{SINGLY_API_BASE}/profiles"
  end
end
