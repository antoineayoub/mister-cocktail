class CocktailControllerController < ApplicationController

  def index
    @cocktails = Cocktail.all
  end


end
