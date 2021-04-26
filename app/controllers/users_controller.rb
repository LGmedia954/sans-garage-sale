class UsersController < ApplicationController

    get '/signup' do
      erb :signup
    end

    post '/register' do
      @user = User.new((name: params["name"], email: params["email"], phone: params["phone"], password: params["password"])
      @user.save
      session[:user_id] = @user.id

      redirect '/welcome'

    end

    get '/login' do
      erb :login
    end




    get '/logout' do
        session.clear
        redirect '/'
      end
  
  
  
  
  end