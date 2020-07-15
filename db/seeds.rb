
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

def seed_list
API.new
spells= API.get_library("spells")
    spells["results"].each do |spell|
         spell_info= API.get_url(spell['url'], "spells")
         created = Spell.new(
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
            created.higher_level = spell_info["higher_level"][0]
            created.save
        end
        created.save
        end
    end

    seed_list
