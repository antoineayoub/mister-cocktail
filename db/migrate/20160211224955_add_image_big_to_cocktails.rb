class AddImageBigToCocktails < ActiveRecord::Migration
  def change
    add_column :cocktails, :image_big, :string
  end
end
