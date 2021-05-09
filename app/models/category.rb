require './config/environment'

class Category < ActiveRecord::Base

    has_many :item_categories
    has_many :items, through: :item_categories
    has_many :users, through: :items


    def self.find_by_name(name)
      Category.all.find{|category| category.name == name}
    end
  
end