include RecipeImportHelper

IO.foreach('./lib/assets/recipes/recipes.json')
  .first(2000)
  .map {|raw_line| JSON.parse(raw_line)}
  .each do |recipe_hash|
    recipe = RecipeImportHelper::find_or_create_recipe(recipe_hash)
    RecipeImportHelper::find_or_create_ingredient(recipe, recipe_hash['ingredients'])
    RecipeImportHelper::find_or_create_tag(recipe, recipe_hash['tags'])
  end




