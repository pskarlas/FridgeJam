class AddMandatoryIngredientsCounterColToRecipes < ActiveRecord::Migration[6.1]
  def change
    add_column :recipes, :mandatory_ingredients_count, :integer, default: 0
  end
end
