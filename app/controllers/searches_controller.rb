# frozen_string_literal: true

# app/controllers/searches_controller.rb
class SearchesController < ApplicationController

  def index
    if params[:query].present?
      array_of_strings = params[:query].split(',').push('poivre', 'sel').reject(&:blank?).map(&:strip)
      @recipes = Recipe.search_by_ingredients(array_of_strings)
      @recipes = @recipes.map{ |recipe| RecipeDecorator.new(recipe, view_context)}
    else
      @recipes = Recipe.order("nb_comments DESC").first(10)
      @top_recipes = @recipes.map{ |recipe| RecipeDecorator.new(recipe, view_context)}
    end
  end

  def new
    array_of_strings = search_params[:query].split(',').map(&:strip)
    ingredient_ids = Ingredient.get_ingredient_ids_from(array_of_strings) 
  end

  def show; end
  def create; end 

  private
  def search_params
    params.require(:search).permit(:query)
  end
end
