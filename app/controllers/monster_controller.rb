class MonsterController < ApplicationController
    
    get '/monsters' do
        @monsters= Monster.all
        mon_array = []
        if !params.values.empty?
          if params[:search]
            @monsters.each{|mon| 
            if mon[:name].downcase.include? params[:search].downcase
              mon_array << mon
            elsif mon[:monster_type] == params[:search].downcase
              mon_array << mon
            elsif params[:search] == '1/2' && mon[:challenge_rating] == '0.5'
              mon_array << mon
            elsif params[:search] == '1/4' && mon[:challenge_rating] == '0.25'
              mon_array << mon
            elsif params[:search] == '1/8' && mon[:challenge_rating] == '0.125'
              mon_array << mon
            elsif  mon[:challenge_rating] == params[:search]
              mon_array << mon
            end
          }
            @monsters = mon_array
          end
        end
        erb:'/monsters/monsters'
     end

    get '/monsters/challenge' do
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
    end

    get '/monsters/type' do
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
    end

    get '/monsterbooks' do
        if logged_in?
            erb :'/monsters/monsterbooks'
            else
          login_error
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
                  redirect to '/monsterbooks/new'
                  else
                  new_book = Monsterbook.create(book_name: params[:new_book][:book_name], user: current_user)
                        if params[:new_book][:monsters]
                          params[:new_book][:monsters].values.each do |value|
                              Monster.all.select {|monster| new_book.monsters << monster if monster.id == value.to_i }
                              end
                          end
                end
             
     
          new_book.save
          redirect to "/monsterbooks/#{new_book.id}"
        else
          login_error
        end
      end
        
  
      get '/monsterbooks/:id' do
        if logged_in?
          if Monsterbook.find_by_id(params[:id])
          @monsterbook = Monsterbook.find_by_id(params[:id])
          erb :'/monsters/show_monsterbook'
          else flash[:error] = "Sorry no Monsterbook of that ID exists"
            redirect to '/monsterbooks'
          end
        else
          login_error
        end
      end
      
        get "/monsterbooks/:id/edit" do
          if logged_in?
            if Monsterbook.find_by_id(params[:id])
            @book = Monsterbook.find_by_id(params[:id])
            user = current_user
                if user.id == @book.user_id
                erb :'/monsters/edit'
                else 
                    flash[:error] = "Sorry you do not have permission to do that"
                    redirect to '/monsterbooks'
                end
            else flash[:error] = "Sorry no Monsterbook of that ID exists"
                redirect to '/monsterbooks'
            end
          else redirect to '/monsterbooks'
          end
        end
      
        patch "/monsterbooks/:id" do
          book = Monsterbook.find_by_id(params[:id])
            if current_user.id == book.user_id
              book.update(book_name: params[:update_book][:book_name])
              book.monsters.delete_all
              if params[:update_book][:monsters]
              params[:update_book][:monsters].values.each { |value| Monster.all.select {|mon| book.monsters << mon if mon.id == value.to_i } }
              end
              
              book.save
              redirect to "/monsterbooks/#{ book.id }"
          else 
              redirect to "/monsterbooks/#{book.id}/edit"
          end
        end
      
        delete "/monsterbooks/delete/:id" do
          if logged_in?
            book = Monsterbook.find_by_id(params[:id])
            user = current_user
            if user.id == book.user_id
            book.delete
            redirect to '/monsterbooks'
            else 
              flash[:error] = "Sorry you do not have permission to do that"
              redirect to '/monsterbooks'
            end
            else login_error
          end
        end

end
