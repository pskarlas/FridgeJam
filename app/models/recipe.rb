# frozen_string_literal: true

# app/models/recipe.rb
class Recipe < ApplicationRecord

  # Associations
  has_many :ingredients, dependent: :destroy
  has_many :recipe_tags
  has_many :tags, through: :recipe_tags

  # Scopes
  scope :search_by_ingredients, -> (ingredients_array) {
    querable_array = ingredients_array.map { |val| "%#{val}%" }
    ingredient_ids = Ingredient
      .select('ingredients.id')
      .where('ingredients.name ILIKE ANY (array[?])', querable_array)
    
    joins(:ingredients)
      .where("ingredients.optional = false AND ingredients.id IN (?)", ingredient_ids)
      .group('recipes.id')
      .having("COUNT(ingredients.id) = recipes.mandatory_ingredients_count", ingredient_ids)
  }
end
