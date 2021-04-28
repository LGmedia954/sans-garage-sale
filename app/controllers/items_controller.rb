require './config/environment'
require 'rack-flash'

class ItemsController < ApplicationController

    get '/item/new' do
      @catergories = Category.all
      erb :'/item/new'
    end

    post 'items' do
      if params[:name] == "" || params[:quantity] == "" || params[:condition] == "" || params[:price] == ""
        flash[:input_error] = "All fields are required. Enter 0 for free items."
        redirect to '/item/new'
      else
        @item = Item.create(params)

        category_file = params[:item][:categories]
        category_file.each do |c|
          @item.categories << Category.find(category)
        end

        @item.save
        redirect '/show_listing/#{@item.last}'
      end

    end

    get '/listings' do
      #Trying this code here...
      #@venue = Venue.includes({:orders => [:customer, :items]}).find_by_handle(params[:venue])
      @item = Item.includes({:items => [:name, :quantity, :condition, :price]}, {:users => [:name, :email, :phone]}).find_by_id(params[:item])
      erb :'/listings'
    end

    get '/item/:name' do
      name = params[:name]
      @item = Item.find_by_name(name)
      erb :'/show_listing'
    end

    get '/item/edit' do
      erb :'edit_listing'
    end

    get '/my_listings' do
      erb :'my_listings'
    end

    #need delete_listing
    
end

