# frozen_string_literal: true

# Helper methods for importing recipes
module RecipeImportHelper

  def calculate_ttl_cook_time(string)
    return if string.strip.nil? || string.strip.blank?
    arr = extract_time_from(string)
    ttl_mins_from_days  = arr[0] * 1440
    ttl_mins_from_hours = arr[1] * 60
    ttl_mins            = arr[2]

    ttl_mins_from_days + ttl_mins_from_hours + ttl_mins
  end

  def extract_time_from(s)
    s.scan(/(\d{1,2}\s?j)?\s?(\d{1,2}\s?h)?\s?(\d{1,2}\s?)?\s?/)[0].map(&:to_i)
  end

  def find_or_create_recipe(recipe_hash)
    Recipe.find_or_create_by(
      name:        recipe_hash['name'],
      rate:        recipe_hash['rate'],
      author_tip:  recipe_hash['author_tip'],
      budget:      recipe_hash['budget'],
      prep_time:   recipe_hash['prep_time'],
      author:      recipe_hash['author'],
      difficulty:  recipe_hash['difficulty'],
      people_quantity: recipe_hash['people_quantity'],
      cook_time:   recipe_hash['cook_time'],
      total_time:  recipe_hash['total_time'],
      image:       recipe_hash['image'],
      nb_comments: recipe_hash['nb_comments']
    )
  end

  def find_or_create_ingredient(recipe, json_ingredients )
    json_ingredients.each do |ingr|
      ingredient = Ingredient.find_or_create_by(name: ingr, recipe_id: recipe.id)
    end
  end

  def find_or_create_tag(recipe, json_tags )
    json_tags.each do |tag|
      tag = Tag.find_or_create_by(name: tag)
      RecipeTag.find_or_create_by(recipe_id: recipe.id, tag_id: tag.id)
    end
  end


end
