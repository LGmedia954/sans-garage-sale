require './config/environment'
require 'rack-flash'
require 'pry'

class ItemsController < ApplicationController

  use Rack::Flash

  get '/listings' do
    if logged_in?
      @items = Item.all
      erb :'/listings'
    else
      redirect to '/login'
    end
  end
  
    get '/items/new' do
      if logged_in?
        @categories = Category.all
        erb :'/add_listing'
      else   
        redirect to '/login'
      end
    end
    

    #CREATE
    post '/items' do
      if !logged_in?
        redirect to '/login'
      else
        if params[:name] == "" || params[:quantity] == "" || params[:condition] == "" || params[:price] == ""
          flash[:input_error] = "All fields are required. Enter 0 for free items."
          redirect to '/item/new'
        else
          #binding.pry
          @item = current_user.items.build(params[:item])
          
          #@itemcategory = params[:itemcategory][:category_id]
          #params.dig(:itemcategories, :item_id, :category_id)   


          #Instead of this below, I decided to limit choices to 15 categories.
          #category_list = params[:item][:categories]
          #category_list.each do |category|
            #@item.categories << Category.find(category)
          #end
          
          @item.save

          flash[:message] = "Item added."
          redirect to "/items/#{@item.id}"
        end
      end
    end

     #READ
     get '/items/' do
      if logged_in?
        @item = Item.find_by_id(params[:id])
        #@items = Item.last.where(params[:user_id] == current_user.id)
        erb :'/show_listing'
      else
        redirect to '/login'
      end
    end
    
    #EDIT
    get '/items/:id/edit' do
      if logged_in?
        @item = Item.find_by_id(params[:id])
        if @item && @item.user == current_user
          erb :'/edit_listing'
        else
          redirect to '/listings'
        end
      else
        redirect to '/login'
      end
    end


    #User can see their own listings.
    get '/my_listings' do
      if logged_in?
        @items = Item.all.where(params[:user_id] == current_user.id)
        erb :'/my_listings'
      else
        redirect to '/login'
      end
    end


    get '/items/:name' do
      if logged_in?
        @item = Item.find_by_name(params[:name])
        erb :"/show_listing"
      else
        redirect to '/login'
      end
    end


    #PATCH
    patch '/items/:id' do
      if logged_in?
        @item = Item.find_by_id(params[:id])
        if @item && @item.user == current_user
          @item.update(params[:item])

          @item.category_ids = params[:categories]
          @item.save
  
          flash[:message] = "Item updated."
          redirect to "/items/#{@item.id}"
        
        else
          redirect to '/listings'
        end
      else
        redirect to '/login'
      end
    end


    #DELETE
    delete '/items/:id/delete' do
      if logged_in?
        @item = Item.find_by_id(params[:id])
        if @item && @item.user == current_user
          @item.delete
          redirect to '/listings'
        else
          redirect to '/listings'
        end
      else
        redirect to '/login'
      end
    end

    
  end