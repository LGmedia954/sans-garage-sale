require './config/environment'

class Item < ActiveRecord::Base

    belongs_to :user
    has_many :item_categories
    has_many :categories, through: :item_categories

    validates_presence_of :name, :quantity, :condition, :price
  
end