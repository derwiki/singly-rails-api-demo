require 'httparty'

class AuthController < ApplicationController

  def service
    redirect_to auth_url(params[:service])
  end

  SINGLY_API_BASE = "https://api.singly.com"

  def callback
    data = HTTParty.post(
      token_url,
      {:body => token_params(params[:code])}
    ).parsed_response
    session[:access_token] = data['access_token']
    redirect_to "/"
  end

  def logout
    session.clear
    redirect_to "/"
  end

private

  def token_params(code)
    {
      :client_id => ENV["SINGLY_ID"],
      :client_secret => ENV["SINGLY_SECRET"],
      :code => code
    }
  end

  def token_url
    "#{SINGLY_API_BASE}/oauth/access_token"
  end

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
