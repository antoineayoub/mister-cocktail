class AddUpVoteToCocktails < ActiveRecord::Migration
  def change
    add_column :cocktails, :upvote, :integer
  end
end
