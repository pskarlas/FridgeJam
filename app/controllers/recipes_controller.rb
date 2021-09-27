# frozen_string_literal: true

# app/controllers/recipes_controller.rb
class RecipesController < ApplicationController

  # GET /recipes/1
  def show
    recipe = Recipe.find_by(id: params[:id], slug: params[:slug])
    @recipe = RecipeDecorator.new recipe, view_context
  end
end
