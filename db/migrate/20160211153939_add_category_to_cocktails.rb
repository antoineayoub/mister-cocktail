class AddCategoryToCocktails < ActiveRecord::Migration
  def change
    add_column :cocktails, :category, :string
  end
end
