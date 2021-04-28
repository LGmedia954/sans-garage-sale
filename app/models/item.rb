require './config/environment'

class Item < ActiveRecord::Base

    belongs_to :user
    has_many :item_categories
    has_many :categories, through: :item_categories

    validates :name, :presence => true
    validates :quantity, :presence => true
    validates :condition, :presence => true
    validates :price, :presence => true
  
end