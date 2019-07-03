class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    client_id = ENV['GITHUB_CLIENT_ID']
    client_secret = ENV['GITHUB_CLIENT_SECRET']
    code = params[:code]
    resp = Faraday.post "https://github.com/login/oauth/access_token" do |req|
    req.body = { client_id: ENV["GITHUB_CLIENT_ID"], client_secret: ENV["GITHUB_CLIENT_SECRET"], code: params[:code] }
    req.headers['Accept'] = 'application/json'
    end
    resp_body = JSON.parse(resp.body)
    session[:token] = resp_body['access_token']

    response = Faraday.get "https://api.github.com/user", {}, {
      'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'
    }
    response_body = JSON.parse(response.body)
    session[:username] = response_body["login"]

    redirect_to "/"
  end
end
