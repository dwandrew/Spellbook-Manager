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

end
