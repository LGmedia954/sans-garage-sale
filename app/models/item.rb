require './config/environment'

class Item < ActiveRecord::Base

    belongs_to :user
    belongs_to :category
    has_many :item_categories
    has_many :categories, through: :item_categories

    validates_presence_of :name, :quantity, :condition, :price


    def self.create_new_listing(item_details, current_user)

      @item_details = item_details
      @user = current_user

        @item = Item.new(
            :name => @item_details[:name],
            :quantity => @item_details[:quantity],
            :condition => @item_details[:condition],
            :price => @item_details[:price],
            :user_id => @item_details[:user_id],
            :category_id => @item_details[:category_id],
        )

          @item.user = @user

          @item.save

          @item

        end


end