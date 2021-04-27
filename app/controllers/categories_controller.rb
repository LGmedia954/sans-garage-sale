class CategoriesController < ApplicationController

    get '/categories' do
      @categories = Categories.all
      erb :'categories/index'
    end

    get '/categories/:name' do
      name = params[:name]
      @category = Category.find_by_name(name)
      erb :'categories/show'
    end
    
end