class AddImageToCocktails < ActiveRecord::Migration
  def change
    add_column :cocktails, :image, :string
  end
end
