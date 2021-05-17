class ItemCategories < ActiveRecord::Migration[5.2]
  
  #This is the join table.
  #Category_id column has since been shifted to the Items table,
  #to allow the initial input form to carry params via Item.
  #This move discontinued the items showing on their respective Category pages.
  #I plan to revisit this later, maybe rename this column below to c_id
  #then reworking somehow the initial add_listing form.

  def change
    create_table :item_categories do |t|
      t.integer :item_id
      t.integer :category_id
    end
  end

end
