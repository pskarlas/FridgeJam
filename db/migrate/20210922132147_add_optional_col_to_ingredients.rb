class AddOptionalColToIngredients < ActiveRecord::Migration[6.1]
  def change
    add_column :ingredients, :optional, :boolean, default: false
  end
end
