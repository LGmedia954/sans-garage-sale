require './config/environment'

class User < ActiveRecord::Base

    has_many :items
    has_many :categories, through: :items
    has_secure_password

    validates_presence_of :name, :email, :phone
    validates_uniqueness_of :email
    
end