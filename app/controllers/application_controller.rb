require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'password_security'
    use Rack::Flash
  end

  get "/" do
    flash[:message]=nil
    erb :welcome
  end

  get '/signup' do
    erb :signup
  end

  post '/signup' do
    @instructor=Instructor.new(params)
    if EmailAddress.valid?(params[:email]) && @instructor.save
      session[:user_id] = @user.id
      redirect to '/instructors'
    else
      if @instructor.name==""
        flash[:message] = "Username can't be blank"
      elsif !EmailAddress.valid?(@instructor.email)
        flash[:message] = "Please add valid email address"
      elsif @instructor.password_digest==nil
        flash[:message] = "Password can't be blank"
      else
        flash[:message] = "Account with this username or email already exist"
      end
      redirect to '/signup'
    end
  end


  get '/login' do
    erb :login
  end



end
