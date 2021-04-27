class CategoriesController < ApplicationController

    get '/categories' do
      @categories = Categories.all
      erb :'categories/index'
    end

    get '/categories/:name' do
      @category = Category.find_by_name(params[:name])
      erb :'categories/show'
    end
    
end