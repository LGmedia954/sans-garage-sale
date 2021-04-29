require './config/environment'
require 'rack-flash'

class UsersController < ApplicationController

    get '/signup' do
      if !logged_in?
        erb :'/signup'
      else
        redirect to '/listings'
      end
    end

    post '/signup' do
      if params[:name] == "" || params[:email] == "" || params[:phone] == "" || params[:password] == ""
        flash[:onboard_error] = "All fields are required."
        redirect to '/signup'
      else
        @user = User.create(params)
        session[:email] = @user.id
        redirect '/listings'
      end
    end

    get '/login' do
      if !logged_in?
        erb :'/login'
      else
        redirect to '/listings'
      end
    end

    post '/login' do
      user = User.find_by(:name => params[:name])
      if user && user.authenticate(params[:password])
        session[:email] = user.id
        redirect to '/listings'
      else
        flash[:login_error] = "Password incorrect. Please try again."
        redirect to '/signup'
      end
    end

    get '/logout' do
      if logged_in?
        session.destroy
        redirect to '/login'
      else
        redirect to '/'
      end
    end
  
  
  end