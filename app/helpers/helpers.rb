require 'sinatra/base'

class Helpers
  def self.current_user(session)
    @user = Instructor.find(session[:user_id])
  end

  def self.logged_in?(session)
    !!session[:user_id]
  end
end
