require './config/environment'

class Category < ActiveRecord::Base

    has_many :items
    has_many :users, through: :items
    has_many :item_categories
    has_many :items, through: :item_categories

  
end