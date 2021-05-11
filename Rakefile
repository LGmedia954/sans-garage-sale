ENV["SINATRA_ENV"] ||= "development"

require_relative './config/environment'
require 'sinatra/activerecord/rake'

# Type `rake -T` on your command line to see the available rake tasks.

#namespace :db do
  #task :load_config do
    #require "./app"
  #end
#end

task :console do
  Pry.start
end