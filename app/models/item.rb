require './config/environment'

class Item < ActiveRecord::Base

    belongs_to :user
    has_many :item_categories
    has_many :categories, through: :item_categories

    validates_presence_of :name, :quantity, :condition, :price


    def self.find_by_id(id)
      Item.all.find { |item| item.id == id }
    end

  
end