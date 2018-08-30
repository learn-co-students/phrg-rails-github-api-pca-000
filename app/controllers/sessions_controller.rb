class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    # debugger
    response = Faraday.post "https://github.com/login/oauth/access_token" do |req|
      req.body = {'client_id': 'c12ab5a5aac576dbe275', 'client_secret': 'a941caf4413752b96cc7b1d0dd867d953bd33b55', 'code': params[:code] }
      req.headers['Accept'] = 'application/json'
      end
    body = JSON.parse(response.body)
    session[:token] = body["access_token"]
    redirect_to root_path
  end
end






















# class SessionsController < ApplicationController
# skip_before_action :authenticate_user
#   def create
#
#     resp = Faraday.post("https://github.com/login/oauth/access_token") do |req|
#       req.params['client_id'] = 'c12ab5a5aac576dbe275'
#       req.params['client_secret'] = 'a941caf4413752b96cc7b1d0dd867d953bd33b55'
#       req.params['redirect_uri'] = "http://localhost:3000/auth"
#       req.params['code'] = params[:code]
#
#     end

#     body = JSON.parse(resp.body)
#     session[:token] = body["access_token"]

#     redirect_to root_path
#   end
# end
