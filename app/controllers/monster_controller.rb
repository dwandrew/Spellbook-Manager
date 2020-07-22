class MonsterController < ApplicationController
    
    get '/monsters' do
        if logged_in?
        @monsters= Monster.all
        erb:'/monsters/monsters'
        else 
        login_error
        end
     end

    get '/monsters/challenge' do
        if logged_in?
            @monsters = {}
            Monster.all.each do |monster|
                if @monsters["#{monster.challenge_rating}"]
                    @monsters["#{monster.challenge_rating}"] << monster
                else 
                    @monsters["#{monster.challenge_rating}"] = []
                    @monsters["#{monster.challenge_rating}"] << monster
                end
            end
            @monsters = @monsters.sort_by {|k,v| k.to_f}
            erb:'/monsters/challenge'
        else login_error
        end

    end

    get '/monsters/type' do
        if logged_in?
            @monsters = {}
            Monster.all.each do |monster|
                if @monsters["#{monster.monster_type}"]
                    @monsters["#{monster.monster_type}"] << monster
                else 
                    @monsters["#{monster.monster_type}"] = []
                    @monsters["#{monster.monster_type}"] << monster
                end
            end
            @monsters = @monsters.sort_by {|k,v| k}
            erb:'/monsters/type'
        else login_error
        end

    end

    get '/monsterbooks' do
        if logged_in?
            erb :'/monsters/monsterbooks'
            else
        l   ogin_error
        end
    end


    get '/monsterbooks/new' do
        if logged_in?
            @monsters = Monster.all
          erb :'/monsters/new_book'
        else
          login_error
        end
      end
  
      post '/monsterbooks/finish' do
        if logged_in?
              if current_user.monsterbooks.find_by book_name: params[:new_book][:book_name]
                  flash[:error]= "Already Book of that Title, please choose another Book Name"
                  redirect to '/monsterbook/new'
                  else
                  new_book = Monsterbook.create(book_name: params[:new_book][:book_name], user: current_user)
                        if params[:new_book][:monsters]
                          params[:new_book][:monsters].values.each do |value|
                              Monster.all.select {|monster| new_book.monsters << monster if monster.id == value.to_i }
                              end
                          end
                end
             
     
          new_book.save
          redirect to "/monsterbook/#{new_book.id}"
        else
          login_error
        end
      end
        
  
      get '/monsterbooks/:id' do
        if logged_in?
          if Monsterbook.find_by_id(params[:id])
          @monsters = Monsterbook.find_by_id(params[:id])
          erb :'/monsters/show_monsterbook'
          else flash[:error] = "Sorry no Monsterbook of that ID exists"
            redirect to '/monsterbooks'
          end
        else
          login_error
        end
      end
      
        # get "/monsters/:id/edit" do
        #   if logged_in?
        #     if Monsterbook.find_by_id(params[:id])
        #     @book = Spellbook.find_by_id(params[:id])
        #     user = current_user
        #     if user.id == @book.user_id
        #       type = @book.book_class
        #       @spell_list = Spell.all.select{|spell| spell if spell.classes.include? type}.sort_by{|spell| spell[:level]}
        #       @user_spells = current_user.newspells.select{|spell| spell if spell.classes.include? type}.sort_by{|spell| spell[:level]}
        #       erb :'/spellbook/edit'
        #     else 
        #           flash[:error] = "Sorry you do not have permission to do that"
        #           redirect to '/spellbooks'
        #     end
        #   else flash[:error] = "Sorry no Spellbook of that ID exists"
        #     redirect to '/spellbooks'
        #   end
        #   else redirect to '/spellbooks'
        #   end
        # end
      
        # patch "/spellbooks/:id" do
        #   book = Spellbook.find_by_id(params[:id])
        #     user = current_user
        #     if user.id == book.user_id
        #       book.update(book_name: params[:update_book][:book_name])
        #       book.spells.delete_all
        #       book.newspells.delete_all
        #       if params[:update_book][:spells]
        #       params[:update_book][:spells].values.each do |value|
        #         Spell.all.select {|spell| book.spells << spell if spell.id == value.to_i }
        #         end
        #       end
        #       if params[:new_book]
        #           params[:new_book][:user_spells].values.each do |value|
        #             current_user.newspells.select {|spell| book.newspells << spell if spell.id == value.to_i }
        #       end
        #     end
              
        #       book.save
        #       redirect to "/spellbooks/#{ book.id }"
        #   else 
        #       redirect to "/spellbooks/#{book.id}/edit"
        #   end
        # end
      
        # delete "/spellbooks/delete/:id" do
        #   if logged_in?
        #     book = Spellbook.find_by_id(params[:id])
        #     user = current_user
        #     if user.id == book.user_id
        #     book.delete
        #     redirect to '/spellbooks'
        #     else 
        #       flash[:error] = "Sorry you do not have permission to do that"
        #       redirect to '/books'
        #     end
        #     else login_error
        #   end
        # end

end
