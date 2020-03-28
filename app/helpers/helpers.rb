require 'sinatra/base'

class Helpers

  def self.current_user
    Instructor.find(session[:user_id])
  end

  def logged_in?
    !!session[:user_id]
  end
end
