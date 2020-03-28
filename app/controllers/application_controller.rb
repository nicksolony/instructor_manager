require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'password_security'
  end

  get "/" do
    erb :welcome
  end

  get '/signup' do
    erb :signup
  end

  post '/signup' do
    binding.pry
  end
  get '/login' do
    erb :login
  end




end
