include RecipeImportHelper

IO.foreach('./lib/assets/recipes/recipes.json')
  .map {|raw_line| JSON.parse(raw_line)}
  .each do |recipe_hash|
    recipe = find_or_create_recipe(recipe_hash)
    find_or_create_ingredient(recipe, recipe_hash['ingredients'])
    find_or_create_tag(recipe, recipe_hash['tags'])
  end
