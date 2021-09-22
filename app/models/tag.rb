# frozen_string_literal: true

# app/models/tag.rb
class Tag < ApplicationRecord
  has_many :recipe_tags
  has_many :recipes, through: :recipe_tags
end
