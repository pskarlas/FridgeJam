class AddTsvectorColAndIndex < ActiveRecord::Migration[6.1]
  def change
    add_column :ingredients, :tsv_name, :tsvector
    add_index  :ingredients, :tsv_name, using: :gin
  end
end
