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
  scope :search_by_ingredients, -> (ingredients_array, people, max_time, flexible_search=true) {
    tsvector_clause, ingredients_length = build_tsvector_clause_from(ingredients_array)
    find_by_sql(["
      SELECT r.* FROM recipes r
      INNER JOIN (
        SELECT ingredients.id, ingredients.recipe_id
        FROM ingredients
        WHERE ingredients.id IN (SELECT ingredients.id FROM ingredients
                                 WHERE (#{tsvector_clause}) AND ingredients.optional = false)
      ) q_1 ON r.id = q_1.recipe_id
      WHERE r.people_quantity >= ? AND CAST(r.total_time AS int) <= ?
      GROUP BY r.id
      HAVING COUNT(q_1.id) #{flexible?(flexible_search)}
    ", people || 0, max_time || 90000])
  }


  private

  # Build a flexible search query
  def self.flexible?(flexible)
    return '= r.mandatory_ingredients_count' if flexible == nil
    return '>= 3' if flexible == 'true'
  end

  def self.build_tsvector_clause_from(array)
    ingredients_string_clause =  String.new
    ingredients_length = array.size
    create_ingredients_clause = array.each_with_index do |ingr, i|
      # Get rid of apostrophes
      ingr = ingr.tr(?', ' ')
      # Build the clause
      ingredients_string_clause << "(ingredients.tsv_name @@ websearch_to_tsquery('#{ingr}'))" # or plain_to_tsquery
      ingredients_string_clause << " OR " if i < ingredients_length - 1
    end
    return ingredients_string_clause, ingredients_length
  end

  def import_actions
    self.slug = name.parameterize
    self.total_time = calculate_ttl_cook_time(self.total_time)
  end

end
