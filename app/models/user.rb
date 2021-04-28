require './config/environment'

class User < ActiveRecord::Base

    has_many :items
    has_many :categories, through: :items
    has_secure_password

    validates :name, :presence => true
    validates :email, :presence => true
    validates :phone, :presence => true
    validates_uniqueness_of :email
    
end