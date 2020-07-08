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
            erb :'/spellbook/show_spell'
        else
          login_error
        end
    end
    
    get '/spellbooks/new' do
      if logged_in?
        erb :'/spellbook/new_book'
      else
        login_error
      end
    end

    post '/spellbooks/type' do
      if logged_in?
        if params.values
        type = params.values[0]
        @spell_list = Spell.all.select{|spell| spell if spell.classes.include? type}.sort_by{|spell| spell[:level]}
          erb :'/spellbook/select_spells'
        else 
          flash[:error] = "Please Select a Class for the spellbook"
          redirect to '/spellbooks/new'
        end
      else
        login_error
      end
    end

    post '/spellbooks/finish' do
      if logged_in?
        new_book = Spellbook.create(book_name: params[:new_book][:spellbook_name], user: current_user)
        spells_list = []
        params[:new_book][:spells].values.each do |value|
        Spell.all.select {|spell| spells_list << spell if spell.id == value.to_i }
        end
        new_book.spells = spells_list
        binding.pry
        new_book.save
        redirect to '/spellbooks'
      else
        login_error
      end
    end
      
  

    get '/spellbooks/:id' do
      if logged_in?
        Spellbook.find_by_id(params[:id])
        @spellbook = Spellbook.find_by_id(params[:id])
        erb :'/spellbook/show_spellbook'
      else
        login_error
      end
    end
    
      # get "/post/:id/edit" do
      #   if logged_in?
      #     if Post.find(params[:id])
      #       @post = Post.find(params[:id])
      #       user = current_user
      #         if user.id == @post.user_id
      #         erb :'edit'
      #         else 
      #           flash[:error] = "Sorry you do not have permission to do that"
      #           redirect to '/posts'
      #         end
      #     else 
      #       no_post
      #     end
      #   else redirect to '/login'
      #   end
      # end
    
      # patch "/post/:id" do
      #   @post = Post.find(params[:id])
      #   if !params[:post][:content].empty?
      #   @post.update(title: params[:post][:title].strip, content: params[:post][:content].strip)
      #     if params[:post][:player_access] == 'on'
      #     @post.update(player_access: false)
      #     end
      #   redirect to "/post/#{ @post.id }"
      #   else redirect to "/post/#{@post.id}/edit"
      #   end
      # end
    
      # delete "/post/:id" do
      #   post = Post.find(params[:id])
      #   user = current_user
      #   if user.id == post.user_id
      #   post.delete
      #   redirect to '/posts'
      #   else 
      #     flash[:error] = "Sorry you do not have permission to do that"
      #     redirect to '/posts'
      #   end
      # end
end



# User.where(weekly_subscriber: true).find_each do |user|
#   NewsMailer.weekly(user).deliver_now
# end