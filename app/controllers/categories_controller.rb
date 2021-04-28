require './config/environment'
require 'rack-flash'

class CategoriesController < ApplicationController
  
    get '/categories' do
      @categories = Category.all
      erb :'/categories'
    end

    get '/categories/:name' do
      @category = Category.find_by_name(params[:name])
      erb :'/items_by_category'
    end
    
end