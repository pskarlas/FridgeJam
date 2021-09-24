# frozen_string_literal: true

# Seed the database with recipies.
File.readlines('./lib/assets/recipes/recipes.json').first(100).each do |line|
  # Parse each file line as json
  json_recipe = JSON.parse line
  # Create recipe
  recipe = Recipe.find_or_create_by(
    name:        json_recipe['name'],
    rate:        json_recipe['rate'],
    author_tip:  json_recipe['author_tip'],
    budget:      json_recipe['budget'],
    prep_time:   json_recipe['prep_time'],
    author:      json_recipe['author'],
    difficulty:  json_recipe['difficulty'],
    people_quantity: json_recipe['people_quantity'],
    cook_time:   json_recipe['cook_time'],
    total_time:  json_recipe['total_time'],
    image:       json_recipe['image'],
    nb_comments: json_recipe['nb_comments']
  )
  # Build Recipe / Ingredients
  json_recipe['ingredients'].each do |ingr|
    ingredient = Ingredient.find_or_create_by(name: ingr, recipe_id: recipe.id)
  end
  
  # Build Recipe / Ingredients 
  json_recipe['tags'].each do |tag|
    tag = Tag.find_or_create_by(name: tag)
    RecipeTag.find_or_create_by(recipe_id: recipe.id, tag_id: tag.id)
  end

end

