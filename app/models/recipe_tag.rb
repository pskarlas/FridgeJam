# frozen_string_literal: true

# app/models/recipe_tag.rb
class RecipeTag < ApplicationRecord
  self.table_name = "recipes_tags"
  belongs_to :recipe
  belongs_to :ingredient
end