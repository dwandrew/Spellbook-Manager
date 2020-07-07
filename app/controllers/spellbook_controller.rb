class SpellbookController < ApplicationController

    get '/spells' do
        if logged_in?
        @spells= Spell.all
        erb:'/spellbook/spells'
        else 
        login_error
        end
    end

    get '/spells/:id' do
        if logged_in?
            Spell.find_by_id(params[:id])
            @spell = Spell.find_by_id(params[:id])
            erb :'/spellbook/show'
        else
          login_error
        end
      end
    
      get "/post/:id/edit" do
        if logged_in?
          if Post.find(params[:id])
            @post = Post.find(params[:id])
            user = current_user
              if user.id == @post.user_id
              erb :'edit'
              else 
                flash[:error] = "Sorry you do not have permission to do that"
                redirect to '/posts'
              end
          else 
            no_post
          end
        else redirect to '/login'
        end
      end
    
      patch "/post/:id" do
        @post = Post.find(params[:id])
        if !params[:post][:content].empty?
        @post.update(title: params[:post][:title].strip, content: params[:post][:content].strip)
          if params[:post][:player_access] == 'on'
          @post.update(player_access: false)
          end
        redirect to "/post/#{ @post.id }"
        else redirect to "/post/#{@post.id}/edit"
        end
      end
    
      delete "/post/:id" do
        post = Post.find(params[:id])
        user = current_user
        if user.id == post.user_id
        post.delete
        redirect to '/posts'
        else 
          flash[:error] = "Sorry you do not have permission to do that"
          redirect to '/posts'
        end
      end
end