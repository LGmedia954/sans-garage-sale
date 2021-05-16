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
        @categories = Category.all
        erb :'/add_listing'
      else   
        redirect to '/login'
      end
    end
    

    #CREATE
    post '/items/' do
      if !logged_in?
        redirect to '/login'
      else
        if params[:name] == "" || params[:quantity] == "" || params[:condition] == "" || params[:price] == ""
          flash[:input_error] = "All fields are required. Enter 0 for free items."
          redirect to '/item/new'
        else
          #@item = current_user.items.build(params[:item])
           
          #@item.save 

          item_details = {
            :name => @params["name"],
            :quantity => @params["quantity"],
            :condition => @params["condition"],
            :price => @params["price"],
            :category_id => @params["category_id"]
          }

          binding.pry

          @item = Item.create_new_listing(item_details, current_user)

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