class DefaultController < ApplicationController
  def home
    if session[:access_token]
      @profiles = HTTParty.get(profiles_url, {
                    :query => {:access_token => session[:access_token]}
                  }).parsed_response
    end
  end

private

  SINGLY_API_BASE = "https://api.singly.com"

  def profiles_url
    "#{SINGLY_API_BASE}/profiles"
  end
end
