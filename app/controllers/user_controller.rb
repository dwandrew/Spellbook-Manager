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

    get '/newspell' do
      if logged_in?
        erb :'user/new_spell'
      else
        login_error
      end
    end

    post '/newspell' do
      if logged_in?
        spell = current_user.newspells.build
        spell.name = params[:newspell][:name]
        spell.level = params[:newspell][:level]
        spell.school = params[:newspell][:school]
        spell.classes = params[:newspell][:classes].join(", ")
        spell.range = params[:newspell][:range]
        spell.components = params[:newspell][:components].join(", ")
        spell.material = params[:newspell][:material]
        params[:newspell][:ritual] == 'on' ? spell.ritual = true : spell.ritual = false
        params[:newspell][:concentration] == 'on' ? spell.concentration = true : spell.concentration = false
        spell.duration = params[:newspell][:duration]
        spell.casting_time = params[:newspell][:casting_time]
        spell.desc = params[:newspell][:desc]
        params[:newspell][:higher_level] ? spell.higher_level = params[:newspell][:higher_level] : spell.higher_level = "n//a"
        spell.save
        redirect to '/userspells'
      else
        login_error
      end

    end

    get '/userspells' do
      if logged_in?
        @spells = current_user.newspells
        erb :'/user/user_spells'
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