require './config/environment'
require 'uri'

class User < ActiveRecord::Base

    has_many :items
    has_many :categories, through: :items
    has_secure_password

    validates_presence_of :name, :email, :phone, :password, message: "fields cannot be blank."
    validates_uniqueness_of :email, message: "email already on file."

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

    def is_valid_email?(email)
      email =~ VALID_EMAIL_REGEX
    end

end