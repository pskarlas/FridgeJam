# frozen_string_literal: true

# app/models/recipe.rb
class Recipe < ApplicationRecord
  has_many :ingredients
  has_many :recipe_tags
  has_many :tags, through: :recipe_tags
end
