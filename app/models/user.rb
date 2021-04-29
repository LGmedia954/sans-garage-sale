require './config/environment'
require 'uri'

class User < ActiveRecord::Base

    has_many :items
    has_many :categories, through: :items
    has_secure_password

    #validates_presence_of :name, :email, :phone
    #validates_uniqueness_of :email


    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

end