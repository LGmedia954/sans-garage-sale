class ItemCategories < ActiveRecord::Migration[5.2]
  
  #This is the join table.

  def change
    create_table :item_categories do |t|
      t.integer :item_id
      t.integer :category_id
    end
  end

end
