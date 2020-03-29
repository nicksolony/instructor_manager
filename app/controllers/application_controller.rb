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
    erb :welcome
  end

  get '/signup' do
    if Helpers.logged_in?(session)
      redirect to "/instructors/#{Helpers.current_user(session).slug}"
    else
      redirect to "/instructors/new"
    end
  end

  get '/login' do
    if Helpers.logged_in?(session)
      redirect to "/instructors/#{Helpers.current_user(session).slug}"
    else
      erb :login
    end
  end

  post '/login' do
    @instructor = Instructor.find_by(name: params[:name])
    if @instructor && @instructor.authenticate(params[:password])
      session[:user_id] = @instructor.id
      redirect to "/instructors/#{Helpers.current_user(session).slug}"
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
