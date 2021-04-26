class UsersController < ApplicationController

    get '/signup' do
      if !logged_in?
        erb :'users/signup'
      else
        redirect to '/listings'
      end
    end

    #post '/signup' do
      #@user = User.new((name: params["name"], email: params["email"], phone: params["phone"], password: params["password"])
      #@user.save
      #session[:user_id] = @user.id

      #redirect '/welcome'

    #end

    get '/login' do
      if !logged_in?
        erb :'users/login'
      else
        redirect to '/listings'
      end
    end

    #post '/login' do



    get '/logout' do
      if logged_in?
        session.clear
        redirect to '/login'
      else
        redirect to '/'
      end
    end
  
  
  end