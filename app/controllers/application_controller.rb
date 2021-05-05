require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base

  configure do
    register Sinatra::ActiveRecordExtension
    use Rack::Flash
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "sgs_secret"
  end

  get '/' do
    erb :index
  end

  helpers do

    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by_id(session[:id]) if session[:id]
    end

  end


end