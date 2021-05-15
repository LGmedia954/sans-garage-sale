require './config/environment'

class Item < ActiveRecord::Base

    belongs_to :user
    belongs_to :category
    has_many :item_categories
    #has_many :categories, through: :item_categories

    validates_presence_of :name, :quantity, :condition, :price


    def self.create_new_listing(item_hashes, item_details, session_uid)
        @item_hashes = item_hashes
        @item_details = item_details
        @user = User.find(session_uid)

        @item = Item.new(
            :item => params["item"]
            :name => params["name"],
            :quantity => params["quantity"],
            :condition => params["condition"],
            :price => params["price"]
            :user_id => params["user_id"]
            :category_id => params["category_id"]
        )

          @item.user = @user

          @item.save

          @item

        end

    

end