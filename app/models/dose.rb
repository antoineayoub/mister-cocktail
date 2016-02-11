class Dose < ActiveRecord::Base
  belongs_to :cocktail
  belongs_to :ingredient
  validates :description, presence: true
  validates :ingredient_id, presence: true
  validates :cocktail_id, presence: true, :uniqueness => { :scope => :ingredient_id }
end
