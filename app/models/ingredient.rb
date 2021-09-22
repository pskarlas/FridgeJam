# frozen_string_literal: true

# app/models/ingredient.rb
class Ingredient < ApplicationRecord
  belongs_to :recipe
end
