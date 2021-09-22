class CreateIngredients < ActiveRecord::Migration[6.1]
  def change
    create_table :ingredients do |t|
      t.belongs_to :recipe, null: false, foreign_key: true
      t.string     :name, null: false
      t.timestamps
    end
  end
end
