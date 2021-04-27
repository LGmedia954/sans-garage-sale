class ItemsController < ApplicationController

    get '/listings' do
      #Some magical code here...
      erb :'/listings'
    end

    get '/item/new' do
      @categories = Category.all
      erb :'/add_listing'
    end

    post 'items' do
      if params[:name] == "" || params[:quantity] == "" || params[:condition] == "" || params[:price] == ""
        flash[:input_error] = "All fields are required. Enter 0 for free items."
        redirect to '/add_listing'
      else
        @item = Item.create(params)

        category_file = params[:item][:categories]
        category_file.each do |c|
          @item.categories << Category.find(category)
        end

        redirect '/show_listing/#{@item.last}'
      end

    end

    get '/show_listing' do
      erb :'show_listing'
    end

    get '/my_listings' do
      erb :'my_listings'
    end
    
end

