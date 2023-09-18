ENV["SINATRA_ENV"] ||= "development"

require_relative './config/environment'
require 'sinatra/activerecord/rake'




desc "Starts Pry console"
task :console do
Pry.start
end

desc "Drops both development and testing databases"
task :drop_all do
  puts "Dropping the databases...."
  system "rm db/spellbook_development.sqlite && rm db/schema.rb"
end

desc "Migrates both development and testing databases"
task :migrations do
  puts "Migrating databases..."
  system "rake db:migrate"
  puts "Seeding database..."
  system "rake db:seed"
  puts "done"
end

desc "Reset All"
task :reset_all do
  Rake::Task["drop_all"].execute
  Rake::Task["migrations"].execute
end

namespace :g do
  desc "Generate migration"
  task :migration do
    name = ARGV[1] || raise("Specify name: rake g:migration your_migration")
    timestamp = Time.now.strftime("%Y%m%d%H%M%S")
    path = File.expand_path("../db/migrate/#{timestamp}_#{name}.rb", __FILE__)
    migration_class = name.split("_").map(&:capitalize).join

    File.open(path, 'w') do |file|
      file.write <<-EOF
class #{migration_class} < ActiveRecord::Migration
  def self.up
  end
  def self.down
  end
end
      EOF
    end

    puts "Migration #{path} created"
    abort # needed stop other tasks
  end
end