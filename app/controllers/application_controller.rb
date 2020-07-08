require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "chris_Perkins_ftw"
    register Sinatra::Flash
  end

  get "/" do
    if logged_in?
      redirect to '/user_profile'
    else
    erb :welcome
    end
  end


    
  helpers do
    def logged_in?
      !!session[:user_id]
    end
    
    def current_user
      User.find_by_id(session[:user_id])
    end

    def login_error
      flash[:error] = "Please Login"
      redirect to "/"
    end

    def no_post
      flash[:error] = "Sorry, that post does not exist"
      redirect to '/posts'
    end

  end



end
