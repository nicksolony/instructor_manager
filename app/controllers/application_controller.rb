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
    if Helpers.logged_in?(session)
      redirect '/instructors'
    else
      erb :welcome
    end
  end

  get '/signup' do
    if Helpers.logged_in?(session)
      redirect to '/instructors'
    else
      erb :signup
    end
  end

  post '/signup' do
    @instructor=Instructor.new(params)
    if EmailAddress.valid?(params[:email]) && @instructor.save
      session[:user_id] = @instructor.id
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
    if Helpers.logged_in?(session)
      redirect to '/instructors'
    else
      erb :login
    end
  end

  post '/login' do
    @instructor = Instructor.find_by(name: params[:name])
    if @instructor && @instructor.authenticate(params[:password])
      session[:user_id] = @instructor.id
      redirect to '/instructors'
    else
      flash[:message] = "Username or Password didn't match"
      redirect to '/login'
    end
  end

  get "/logout" do
    session.clear
    redirect to "/"
  end

end
