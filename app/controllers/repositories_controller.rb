class RepositoriesController < ApplicationController
  def index
    response = Faraday.get "https://api.github.com/user", {}, {'Authorization': "token #{session[:token]}", 'Accept': 'application/json'}
    second_response = Faraday.get "https://api.github.com/user/repos", {}, {'Authorization': "token #{session[:token]}", 'Accept': 'application/json'}
    @name = JSON.parse(response.body)
    @repos = JSON.parse(second_response.body)
  end
end
