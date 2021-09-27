class AddTsvectorColAndIndex < ActiveRecord::Migration[6.1]
  def change
    add_column :ingredients, :tsv_name, :tsvector
    add_index  :ingredients, :tsv_name, using: :gin

    # update current records
    Ingredient.update_all("tsv_name=setweight(to_tsvector(coalesce(name,'')), 'A')")
  end
end
