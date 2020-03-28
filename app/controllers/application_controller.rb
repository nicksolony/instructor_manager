require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'password_security'
    use Rack:Flash
  end

  get "/" do
    erb :welcome
  end

  get '/signup' do
    erb :signup
  end

  post '/signup' do
    binding.pry
    @user=User.new(params)
    if @user.save
      session[:user_id] = @user.id
      redirect to '/instructors'
    else
      flash[:message] = "Please make sure you enter username, email and password!"
      redirect to '/signup'
    end
  end
  get '/login' do
    erb :login
  end




end
