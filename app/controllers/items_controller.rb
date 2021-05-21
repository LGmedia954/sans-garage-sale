require './config/environment'
require 'rack-flash'
require 'pry'

class ItemsController < ApplicationController

  use Rack::Flash

  get '/listings' do  #Logged in Users can read everyone's listings.
    if logged_in?
      @items = Item.all
      erb :'/listings'
    else
      redirect to '/login'
    end
  end
  
    get '/items/new' do
      if logged_in?
        @user = current_user
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

          user = current_user

          @item = user.items.build(name: params["item"]["name"].capitalize,
            quantity: params["item"]["quantity"],
            condition: params["item"]["condition"],
            price: params["item"]["price"],
            category_id: params["item"]["category_id"])   

          @item.save!

          flash[:message] = "Item added."
          redirect to "/items/#{@item.id}"

        end
      end
    end


     #READ
     get '/items/:id' do
      if logged_in?
        @item = Item.find_by_id(params[:id])
        erb :'/show_listing'
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

    
    #EDIT
    get '/items/:id/edit' do
      @item = Item.find_by_id(params[:id])
      if !logged_in?
        redirect to '/login'
      end
      @user = current_user
        if @user == @item.user
          erb :'/edit_listing'
        else
          flash[:message] = "You can only edit your own listings."
          redirect to "/items/#{@item.id}"
        end
     end


    #PATCH
    patch '/items/:id' do
      if logged_in?
        @item = Item.find_by_id(params[:id])
        if @item && @item.user == current_user

          @item.category_id.clear

          @item.update(name: params["item"]["name"].capitalize,
            quantity: params["item"]["quantity"],
            condition: params["item"]["condition"],
            price: params["item"]["price"],
            category_id: params["item"]["category_id"])
  
          @item.save!
          flash[:message] = "Item updated."
          binding.pry
          redirect to "/items/#{@item.id}"
        
        else
          redirect to '/listings'
        end
      else
        redirect to '/login'
      end
    end


    #user = current_user


    #DELETE
    delete '/items/:id/delete' do
      if logged_in?
        @item = Item.find_by_id(params[:id])
        if @item && @item.user == current_user
          @item.delete
          redirect to '/my_listings'
        else
          flash[:message] = "You can only delete your own listings."
          redirect to "/items/#{@item.id}"
        end
      else
        redirect to '/login'
      end
    end

    
  end