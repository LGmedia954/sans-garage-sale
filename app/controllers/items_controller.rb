require './config/environment'
require 'rack-flash'

class ItemsController < ApplicationController

  get '/listings' do
    if logged_in?
      @items = Item.all
      erb :'/listings'
    else
      redirect to '/login'
    end
  end
  
    get '/item/new' do
      if logged_in?
        @categories = Category.all
        erb :'/add_listing'
      else
        redirect to '/login'
      end
    end
      
    #CREATE
    #Will need to add security here
    post '/items' do
      if params[:name] == "" || params[:quantity] == "" || params[:condition] == "" || params[:price] == ""
        flash[:input_error] = "All fields are required. Enter 0 for free items."
        redirect to '/item/new'
      else
        @item = Item.create(params)

        category_list = params[:item][:categories]
        category_list.each do |category|
          @item.categories << Category.find(category)
        end

        @item.save
        redirect '/show_listing/#{@item.last}'
      end

    end


    def all_info
      #I want a nested hash to pull params details for each Item Listing and also pull User params contact info with it.
      #Trying to follow this sample below:
      #@venue = Venue.includes({:orders => [:customer, :items]}).find_by_handle(params[:venue])

      #My code below... still working with it.
      #@item = Item.includes({:items => [:name, :quantity, :condition, :price]}, {:users => [:name, :email, :phone]}).find_by_id(params[:item])
    end

    #READ
    get '/item/:id' do
      name = params[:name]
      @item = Item.find_by_name(name)
      erb :'/show_listing'
    end

    get '/item/:id/edit' do
      name = params[:name]
      @item = Item.find_by_name(name)
      erb :'edit_listing'
    end

    #EDIT
    #Will need to add security here
    patch '/item/:id' do
      @item = Item.find_by_name(params[:name])
      item.name = params[:item][:name]

      if item.categories
        item.categories.clear
      end

      categories = params[:item][:categories]
      
      categories.each do |category|
        item.categories << Category.find(category)
      end

        @item.save
        redirect '/show_listing/#{@item.id}'

    end














    get '/my_listings' do
      if logged_in?
        #@items = User.Items.all
        @categories = Category.all
      erb :'my_listings'
    else
      redirect to '/'
    end
  end

  get '/items/:id' do
    if logged_in?
      @category = Category.find_by_name(params[:name])
      erb :'/my_listings'
    else
      redirect to '/'
    end
  end



    #need delete_listing
    
end

