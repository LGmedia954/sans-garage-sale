class CategoriesController < ApplicationController

    get '/categories' do
      @categories = Category.all
      erb :'/categories'
    end

    get '/categories/:name' do
      @category = Category.find_by_name(params[:name])
      erb :'/show_category'
    end
    
end