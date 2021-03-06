require './config/environment'
require 'rack-flash'
require 'pry'

class ItemsController < ApplicationController

  use Rack::Flash

  get '/listings' do  #Logged in Users can view everyone's listings.
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
          flash[:input_error] = "All fields are required."
          redirect to '/item/new'
          #erb :"/add_listing", locals: {message: "All fields are required. Please try again."}
        else

          user = current_user

          #@item = current_user.items.build(params[:item])

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


     #User can view their own listings.
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

          if params[:name] == "" || params[:quantity] == "" || params[:condition] == "" || params[:price] == ""
            flash[:input_error] = "All fields are required."
            redirect to "/items/#{params[:id]}/edit"
          else

            @item.update(name: params["item"]["name"].capitalize,
              quantity: params["item"]["quantity"],
              condition: params["item"]["condition"],
              price: params["item"]["price"],
              category_id: params["item"]["category_id"])

            @item.save!

            flash[:message] = "Item updated."
            redirect to "/items/#{@item.id}"

          end  
        end
      end   
    end


    #DELETE
    delete '/items/:id/delete' do
      if logged_in?
        @item = Item.find_by_id(params[:id])
        if @item && @item.user == current_user
          @item.delete
          redirect to '/my_listings'
        else
          flash[:message] = "You can only delete your own listings!"
          redirect to "/items/#{@item.id}"
        end
      else
        redirect to '/login'
      end
    end

    
  end