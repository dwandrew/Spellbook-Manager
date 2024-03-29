class MonsterController < ApplicationController
    
    get '/monsters' do
        @monsters= Monster.all
        if !params.values.empty?
          if params[:name]
            @monsters = @monsters.select{|mon| mon if mon[:name] == params[:name].downcase.capitalize()}
          end
          if params[:type]
            @monsters = @monsters.select{|mon| mon if mon[:monster_type] == params[:type].downcase}
          end
          if params[:cr]
          cr =  params[:cr]  
            if cr == '1/2'
              cr = '0.5'
            elsif cr == '1/4'
              cr = '0.25'
            elsif cr == '1/8'
              cr = '0.125'
            end
            @monsters = @monsters.select{|mon| mon if mon[:challenge_rating] == cr}
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
