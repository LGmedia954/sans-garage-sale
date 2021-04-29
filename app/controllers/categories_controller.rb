require './config/environment'
require 'rack-flash'

class CategoriesController < ApplicationController
  
    get '/categories' do
      if logged_in?
        @categories = Category.all
        erb :'/categories'
      else
        redirect to '/login'
      end
    end

    get '/categories/:name' do
      @category = Category.find_by_name(params[:name])
      erb :'/items_by_category'
    end
    
end