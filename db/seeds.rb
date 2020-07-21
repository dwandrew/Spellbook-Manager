
class API
    @@url= "https://www.dnd5eapi.co/api/"

    def self.get_library(library)
        uri = URI.parse("#{@@url}#{library}/")
        response = Net::HTTP.get_response(uri)
        body = response.body
        JSON(body)
    end

    def self.get_url(url, library)
        url = url.gsub("/api/#{library}/", "")
        uri = URI.parse("#{@@url}/#{library}/#{url}")
        response = Net::HTTP.get_response(uri)
        body = response.body
        JSON(body)
    end
end

def seed_list_spells
API.new
    spells= API.get_library("spells")
    spells["results"].each do |spell|
         spell_info= API.get_url(spell['url'], "spells")
         created_spell = Spell.new(
            name: spell_info["name"],
            desc: spell_info["desc"].join(" <br>"),
            range: spell_info["range"],
            components: spell_info["components"].join(", "),
            material: spell_info["material"],
            ritual: spell_info["ritual"],
            concentration: spell_info["concentration"],
            duration: spell_info["duration"],
            casting_time: spell_info["casting_time"],
            level: spell_info["level"],
            school: spell_info["school"]["name"],
            classes: spell_info["classes"].map {|klass| klass["name"]}.join(", ")
         )
            if spell_info["higher_level"]
                created_spell.higher_level = spell_info["higher_level"][0]
                created_spell.save
            end
        created_spell.save
        end
    end

    def seed_list_monsters
    monsters = API.get_library("monsters")
    monsters["results"].each do |monster|
        monster_info = API.get_url(monster['url'], "monsters")
        created_monster = Monster.new(
        name: monster_info["name"],
        monster_type: monster_info["type"],
        monster_subtype: monster_info["subtype"],
        size: monster_info["size"],
        alignment: monster_info["alignment"],
        armor_class: monster_info["armor_class"],
        hit_points: monster_info["hit_points"],
        hit_dice: monster_info["hit_dice"],
        challenge_rating: monster_info["challenge_rating"],
        speed: monster_info["speed"].map {|k,v| "#{k}: #{v}"}.join(", "),
        other_speeds: monster_info["other_speeds"],
        strength: monster_info["strength"],
        dexterity: monster_info["dexterity"],
        constitution: monster_info["constitution"],
        intelligence: monster_info["intelligence"],
        wisdom: monster_info["wisdom"],
        charisma: monster_info["charisma"],
        proficiencies: monster_info["proficiencies"] ? monster_info["proficiencies"].map {|prof| "<em>#{prof["name"]}</em>: +#{prof["value"]}"}.join(" <br><br>") : nil,
        damage_vulnerabilities: monster_info["damage_vulnerabilities"].join(", "),
        damage_resistences: monster_info["damage_resistances"].join(", "),
        damage_immunities: monster_info["damage_immunities"].join(", "),
        condition_immunities: monster_info["condition_immunities"].map{|condition| "#{condition["name"]}"}.join(", "),
        senses:  monster_info["senses"] ? monster_info["senses"].map {|k,v| "#{k}: #{v}"}.join(", ") : nil,
        languages: monster_info["languages"],
        special_abilities: monster_info["special_abilities"] ? monster_info["special_abilities"].map {|ability| "<em>#{ability["name"]}</em>: #{ability["desc"]}"}.join(" <br><br>") : nil,
        actions: monster_info["actions"] ? monster_info["actions"].map {|action| "<em>#{action["name"]}</em>: #{action["desc"]}"}.join(" <br><br>") : nil,
        reactions: monster_info["reactions"] ? monster_info["reactions"].map {|action| "<em>#{action["name"]}</em>: #{action["desc"]}"}.join(", ") : nil,
        legendary_actions: monster_info["legendary_actions"] ? monster_info["legendary_actions"].map {|action| "<em>#{action["name"]}</em>: #{action["desc"]}"}.join(" <br><br>") : nil)
        created_monster.save
        end

    end

    seed_list_monsters
    seed_list_spells

