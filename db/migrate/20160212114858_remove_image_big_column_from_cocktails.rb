class RemoveImageBigColumnFromCocktails < ActiveRecord::Migration
  def change
    remove_column :cocktails, :image_big, :string
  end
end
