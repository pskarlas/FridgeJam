# frozen_string_literal: true

# app/models/recipe.rb
class Recipe < ApplicationRecord
  has_many :ingredients
end
