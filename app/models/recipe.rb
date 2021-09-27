# frozen_string_literal: true

# app/models/recipe.rb
class Recipe < ApplicationRecord
  include RecipeImportHelper
  # Associations
  has_many :ingredients, dependent: :destroy
  has_many :recipe_tags
  has_many :tags, through: :recipe_tags

  # Callbacks
  before_create :import_actions

  # Scopes
  scope :search_by_ingredients, -> (ingredients_array, people, max_time) {
    querable_array = ingredients_array.map { |val| "%#{val}%" }
    ingredient_ids = Ingredient.where('ingredients.name ILIKE ANY (array[?])', querable_array).pluck(:id)
    joins(:ingredients)
      .where('ingredients.optional = false
              AND ingredients.id IN (?)
              AND recipes.people_quantity >= ?
              AND CAST(recipes.total_time AS INT) <= ?',
              ingredient_ids, people, max_time)
      .group('recipes.id')
      .having('COUNT(ingredients.id) = recipes.mandatory_ingredients_count')
  }

  def import_actions
    self.slug = name.parameterize
    self.total_time = calculate_ttl_cook_time(self.total_time)
  end

end
