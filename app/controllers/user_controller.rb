class UserController < ApplicationController


    get '/signup' do
      if logged_in?
        flash[:error] = "Already Logged in, log out to create new profile"
        redirect to '/'
      else
        erb :'user/signup'
      end
      end
    
    
    get '/login' do
        redirect to '/'
    end
    
    post "/login" do
        user = User.find_by(:username => params[:username])
        if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect to '/user_profile'
        else
        flash[:error] = "User details invalid, please retry"
        redirect to "/login"
        end
    end
    
    post "/signup" do
        if params[:password] == params[:confirm_password]
          user = User.new(username: params[:username], password: params[:password])
            if !user.username.empty? && user.save
              session[:user_id] = user.id
              redirect to '/user_profile'
            else
              flash[:error] = "User details invalid, please retry"
              redirect to "/signup"
            end
        else
          flash[:error] = "Password does not match confirm password, please retry"
          redirect to "/signup" 
        end
    end
    
    get '/user_profile' do
        if logged_in?
          erb :'user/profile'
        else 
        login_error
        end
    end

    get '/spellbooks' do
      if logged_in?
        erb :'spellbook/spellbooks'
      else 
        login_error
      end
    end


    get '/logout' do
        if logged_in?
            session.clear
            redirect "/"
        else
            login_error
        end
    end
    
  
    
end