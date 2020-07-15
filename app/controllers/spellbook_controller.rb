class SpellbookController < ApplicationController

    get '/spells' do
        if logged_in?
        @spells= Spell.all
        erb:'/spellbook/spells'
        else 
        login_error
        end
     end

    # get '/spells/:id' do
    #     if logged_in? 
    #         if Spell.find_by_id(params[:id])
    #         Spell.find_by_id(params[:id])
    #         @spell = Spell.find_by_id(params[:id])
    #         erb :'/spellbook/show_spell'
    #         else flash[:error] = "Sorry No Spell of that ID exists"
    #           redirect to '/'
    #         end
    #     else
    #       login_error
    #     end
    # end
    
    get '/spellbooks/new' do
      if logged_in?
        erb :'/spellbook/new_book'
      else
        login_error
      end
    end

    post '/spellbooks/type' do
      if logged_in?
        if !params.values.empty?
        @type = params.values[0]
        @spell_list = Spell.all.select{|spell| spell if spell.classes.include? @type}.sort_by{|spell| spell[:level]}
        @user_spells = current_user.newspells.select{|spell| spell if spell.classes.include? @type}.sort_by{|spell| spell[:level]}
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
        if current_user.spellbooks.find_by book_name: params[:new_book][:book_name]
        flash[:error]= "Already Book of that Title, please choose another Book Name"
        redirect to '/spellbooks/new'
        else
        new_book = Spellbook.create(book_name: params[:new_book][:book_name], book_class: params[:new_book][:book_class], user: current_user)
          if params[:new_book][:spells]
            params[:new_book][:spells].values.each do |value|
            Spell.all.select {|spell| new_book.spells << spell if spell.id == value.to_i }
          end
        end
          if params[:new_book][:user_spells]
            params[:new_book][:user_spells].values.each do |value|
            current_user.newspells.select {|spell| new_book.newspells << spell if spell.id == value.to_i }
            end
          end
        new_book.save
        redirect to "/spellbooks/#{new_book.id}"
        end
      else
        login_error
      end
    end
      

    get '/spellbooks/:id' do
      if logged_in?
        if Spellbook.find_by_id(params[:id])
        @spellbook = Spellbook.find_by_id(params[:id])
        erb :'/spellbook/show_spellbook'
        else flash[:error] = "Sorry no Spellbook of that ID exists"
          redirect to '/spellbooks'
        end
      else
        login_error
      end
    end
    
      get "/spellbooks/:id/edit" do
        if logged_in?
          if Spellbook.find_by_id(params[:id])
          @book = Spellbook.find_by_id(params[:id])
          user = current_user
          if user.id == @book.user_id
            type = @book.book_class
            @spell_list = Spell.all.select{|spell| spell if spell.classes.include? type}.sort_by{|spell| spell[:level]}
            @user_spells = current_user.newspells.select{|spell| spell if spell.classes.include? type}.sort_by{|spell| spell[:level]}
            erb :'/spellbook/edit'
          else 
                flash[:error] = "Sorry you do not have permission to do that"
                redirect to '/spellbooks'
          end
        else flash[:error] = "Sorry no Spellbook of that ID exists"
          redirect to '/spellbooks'
        end
        else redirect to '/spellbooks'
        end
      end
    
      patch "/spellbooks/:id" do
        book = Spellbook.find_by_id(params[:id])
          user = current_user
          if user.id == book.user_id
            book.update(book_name: params[:update_book][:book_name])
            book.spells.delete_all
            book.newspells.delete_all
            if params[:update_book][:spells]
            params[:update_book][:spells].values.each do |value|
              Spell.all.select {|spell| book.spells << spell if spell.id == value.to_i }
              end
            end
            if params[:new_book]
                params[:new_book][:user_spells].values.each do |value|
                  current_user.newspells.select {|spell| book.newspells << spell if spell.id == value.to_i }
            end
          end
            
            book.save
            redirect to "/spellbooks/#{ book.id }"
        else 
            redirect to "/spellbooks/#{book.id}/edit"
        end
      end
    
      delete "/spellbooks/delete/:id" do
        if logged_in?
          book = Spellbook.find_by_id(params[:id])
          user = current_user
          if user.id == book.user_id
          book.delete
          redirect to '/spellbooks'
          else 
            flash[:error] = "Sorry you do not have permission to do that"
            redirect to '/books'
          end
          else login_error
        end
      end
end

