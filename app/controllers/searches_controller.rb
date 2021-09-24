# frozen_string_literal: true

# app/controllers/searches_controller.rb
class SearchesController < ApplicationController
  rescue_from Pagy::OverflowError, with: :redirect_to_homepage

  def index
    if params[:query].present? && !params[:query].strip.blank?
      @people = params[:people] || 0
      @max_ttl_time = params[:total_time] || 200000
      ingredients_array = transform_query_param(params[:query].strip)
      @recipes = search_recipes(ingredients_array, @people, @max_ttl_time).map{ |recipe| RecipeDecorator.new(recipe, view_context)}
      @recipes_count = @recipes.size
      @pagy, @recipes = pagy_array(@recipes, items: 10, size: [1, 2, 1, 1])
    else
      @top_recipes = top10_recipes.map{ |recipe| RecipeDecorator.new(recipe, view_context)}
      @pagy, @top_recipes = pagy_array(@top_recipes, items: 5, size: [1, 2, 1, 1])
    end
  end

  private

  # Transfrom query param to an array of string values
  # and add 'poivre' and 'sel'. Who doesn't have poivre & sel?
  def transform_query_param(query)
    query.split(',').reject(&:blank?).map(&:strip).push('poivre', 'sel')
  end

  # Search for Recipes given an array of ingredients
  def search_recipes(ingredients_array, people, max_ttl_time)
    Recipe.search_by_ingredients(ingredients_array, people, max_ttl_time)
  end

  # Get TOP10 recipes
  def top10_recipes
    Recipe.where.not(rate: nil).order("rate DESC, nb_comments DESC").first(10)
  end

  def redirect_to_homepage(exception)
    redirect_to(
      url_for(page: exception.pagy.last),
      notice: "Recipes page #{params[:page]} was not found. I have therefore redirected you to homepage."
    )
  end

end
