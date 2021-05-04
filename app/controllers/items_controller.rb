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
    post '/items' do
      if logged_in?
        if params[:name] == "" || params[:quantity] == "" || params[:condition] == "" || params[:price] == ""
          flash[:input_error] = "All fields are required. Enter 0 for free items."
          redirect to '/item/new'
        else
          @item = current_user.items.create(:name => params[:name], :quantity => params[:quantity], :condition => params[:condition], :price => params[:price])

          category_list = params[:item][:categories]
          category_list.each do |category|
            @item.categories << Category.find(category)
          end

          @item.save
          redirect to '/items/#{@item.id}'
        end
      end

     end


    def all_listings
      #I want to pull params details for each Item Listing with User params contact info with it.
      #I keep finding only Ruby on Rails examples of this.

      #Trying to follow this code example from StackOverflow below:
      #@venue = Venue.includes({:orders => [:customer, :items]}).find_by_handle(params[:venue])

      #My code below... still working with it.
      #@item = Item.includes({:items => [:name, :quantity, :condition, :price]}, {:users => [:name, :email, :phone]}).find_by_id(params[:item])
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
    get '/item/:id/edit' do
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


   #PATCH
    




    get '/my_listings/' do
      if logged_in?
        @items = Item.all.where(:user_id => current_user.id)
        erb :'/my_listings'
      else
        redirect to '/login'
      end
    end

    
    get '/items_by_category' do
      if logged_in?
        @category = Category.items.all
        erb :'/items_by_category'
      else
        redirect to '/'
      end
    end


    #DELETE
    delete '/item/:id/delete' do
      if logged_in?
        @item = Item.find_by_id(params[:id])
        if @item && @item.user == current_user
          @item.delete
        else
          redirect to '/listings'
        end
      else
        redirect to '/login'
      end
    end

    
  end