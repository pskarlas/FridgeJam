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
    ingredients_string_clause =  String.new
    ingredients_length = ingredients_array.size
    create_ingredients_clause = ingredients_array.each_with_index do |ingr, i|
      # Get rid of apostrophes
      ingr = ingr.tr(?', ' ')
      ingredients_string_clause << "(ingredients.tsv_name @@ plainto_tsquery('#{ingr}'))"
      ingredients_string_clause << ' OR ' if i < ingredients_length - 1
    end

    find_by_sql(["
      SELECT r.* FROM recipes r
      INNER JOIN (
        SELECT ingredients.id, ingredients.recipe_id
        FROM ingredients
        WHERE ingredients.id IN (SELECT ingredients.id FROM ingredients
                                 WHERE (#{ingredients_string_clause.strip}) AND ingredients.optional = false)
                                ) q_1 ON r.id = q_1.recipe_id
      WHERE r.people_quantity >= ? AND CAST(r.total_time AS int) <= ?
      GROUP BY r.id
      HAVING COUNT(q_1.id) = r.mandatory_ingredients_count
    ", people, max_time])
  }

  def import_actions
    self.slug = name.parameterize
    self.total_time = calculate_ttl_cook_time(self.total_time)
  end

end
