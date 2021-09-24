# frozen_string_literal: true

# app/controllers/searches_controller.rb
class SearchesController < ApplicationController
  rescue_from Pagy::OverflowError, with: :redirect_to_last_page

  def index
    if params[:query].present? && !params[:query].strip.blank?
      ingredients_array = transform_query_param(params[:query].strip)
      @recipes = search_recipes(ingredients_array).map{ |recipe| RecipeDecorator.new(recipe, view_context)}
      @recipes_count = @recipes.size
      @pagy, @recipes = pagy_array(@recipes, items: 10, size: [1, 2, 1, 1])
    else
      @top_recipes = top10_recipes.map{ |recipe| RecipeDecorator.new(recipe, view_context)}
      @pagy, @top_recipes = pagy_array(@top_recipes, items: 5, size: [1, 2, 1, 1])
    end
  end

  def new
    array_of_strings = search_params[:query].split(',').map(&:strip)
    ingredient_ids = Ingredient.get_ingredient_ids_from(array_of_strings) 
  end

  private

  # Transfrom query param to an array of string values
  # and add 'poivre' and 'sel'. Who doesn't have poivre & sel?
  def transform_query_param(query)
    query.split(',').reject(&:blank?).map(&:strip).push('poivre', 'sel')
  end

  # Search for Recipes given an array of ingredients
  def search_recipes(ingredients_array)
    Recipe.search_by_ingredients(ingredients_array)
  end

  # Get TOP10 recipes
  def top10_recipes
    Recipe.where.not(rate: nil).order("rate DESC, nb_comments DESC").first(10)
  end

  def redirect_to_last_page(exception)
    redirect_to(
      url_for(page: exception.pagy.last),
      notice: "Recipes page #{params[:page]} was not found. I have therefore redirected you to homepage."
    )
  end

end
