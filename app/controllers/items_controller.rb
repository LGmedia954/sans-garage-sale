require './config/environment'
require 'rack-flash'
require 'pry'

class ItemsController < ApplicationController

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

    get '/show_listing' do
      if logged_in?
        @item = Item.find_by_id(params[:id])
        erb :'/show_listing'
      else
        redirect to '/login'
      end
    end


    #CREATE
    post '/items' do
      if logged_in?
        if params[:name] == "" || params[:quantity] == "" || params[:condition] == "" || params[:price] == ""
          flash[:input_error] = "All fields are required. Enter 0 for free items."
          redirect to '/item/new'
        else
          @item = current_user.items.create(name: params[:name], quantity: params[:quantity], condition: params[:condition], price: params[:price])

          #category_list = params[:item][:categories]
          #category_list.each do |category|
          #  @item.categories << Category.find(category)
          #end

          #@item.save

          flash[:message] = "Item added."
          redirect to '/items/#{@item.id}'
        end
      end
    end


   #READ
   #get '/items/:id' do
   get '/items/' do
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


   




    get '/my_listings' do
      if logged_in?
        #@items = Item.all.where(:user_id => current_user.id)
        @items = Item.all.where(params[:user_id] == current_user.id)
        erb :'/my_listings'
      else
        redirect to '/login'
      end
    end

    
    get '/items_by_category' do
      if logged_in?
        @category = Category.items.all
        erb :'/categories'
      else
        redirect to '/'
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