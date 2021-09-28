# frozen_string_literal: true

# app/models/ingredient.rb
class Ingredient < ApplicationRecord
  # Associations
  belongs_to :recipe

  # Callbacks
  after_create do 
    check_if_optional
    update_recipe_counter
    populate_tsvector
  end

  # Scopes
  scope :get_ingredient_ids_from, -> (array_of_strings) {
    querable_array = array_of_strings.map { |val| "%#{val}%" }
    ingredient_ids = select('ingredients.id')
                      .where('ingredients.name ILIKE ANY (array[?])', querable_array)
  }
  
  private

  def populate_tsvector
    Ingredient.where(id: id).update_all("tsv_name = to_tsvector('english', name)")
  end

  def check_if_optional
    update_attribute(:optional, true) if name.match(/optionnel/)
  end
  
  def update_recipe_counter
    recipe.mandatory_ingredients_count = Ingredient.where(optional: false, recipe_id: recipe.id).count
    recipe.save
  end
end
