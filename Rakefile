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
  system "rm db/development.sqlite && rm db/schema.rb"
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