# frozen_string_literal: true

# app/models/ingredient.rb
class Ingredient < ApplicationRecord
  # Associations
  belongs_to :recipe

  # Callbacks
  after_create do 
    check_if_optional()
    update_recipe_counter
  end

  # In case we decide
  # we want to update/delete ingredients
  after_save    { self.update_recipe_counter }
  after_destroy { self.update_recipe_counter }

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
  
  def update_recipe_counter
    recipe.mandatory_ingredients_count = Ingredient.where(optional: false, recipe_id: recipe.id).count
    recipe.save
  end
end
