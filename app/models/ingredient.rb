# frozen_string_literal: true

# app/models/ingredient.rb
class Ingredient < ApplicationRecord
  # Associations
  belongs_to :recipe

  # Callbacks
  after_create do 
    self.check_if_optional()
    self.update_counter_cache
  end
  after_save { self.update_counter_cache }
  after_destroy { self.update_counter_cache }

  # Scopes
  scope :get_ingredient_ids_from, -> (array_of_strings) {
    querable_array = array_of_strings.map { |val| "%#{val}%" }
    ingredient_ids = select('ingredients.id')
                      .where('ingredients.name ILIKE ANY (array[?])', querable_array)
  }
  
  private

  def check_if_optional
    update_attribute(:optional, true) if name.match(/optionnel/)
  end
  
  def update_counter_cache
    recipe.mandatory_ingredients_count = Ingredient.where(optional: false, recipe_id: recipe.id).count
    recipe.save
  end
end
Ingredient.select("ingredients.id FROM ingredients WHERE ingredients")