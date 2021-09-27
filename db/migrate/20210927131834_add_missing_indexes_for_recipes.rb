class AddMissingIndexesForRecipes < ActiveRecord::Migration[6.1]
  def change
    add_index :recipes, :people_quantity
    add_index :recipes, :total_time
  end
end
