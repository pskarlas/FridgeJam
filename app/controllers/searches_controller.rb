# frozen_string_literal: true

# app/controllers/searches_controller.rb
class SearchesController < ApplicationController

  def index
    if params[:query].present?
      array_of_strings = params[:query].split(',').reject(&:blank?).map(&:strip)
      @recipes = Recipe.search_by_ingredients(array_of_strings)
    else
      @recipes = Recipe.first(5)
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
