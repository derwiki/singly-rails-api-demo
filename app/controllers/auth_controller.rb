class AuthController < ApplicationController

  def service
    redirect_to auth_url(params[:service])
  end

  def callback
    redirect_to "/"
  end

  SINGLY_API_BASE = "https://api.singly.com"

private

  def auth_params(service)
    {
      :client_id => ENV["SINGLY_ID"],
      :redirect_uri => callback_url,
      :service => service
    }.map {|key, value|
      "#{key}=#{value}"
    }.join("&")
  end

  def auth_url(servie)
    "#{SINGLY_API_BASE}/oauth/authorize?#{auth_params(params[:service])}"
  end

  def callback_url
    "#{request.protocol}#{request.host}:#{request.port}/auth_callback"
  end

end
