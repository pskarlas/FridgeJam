class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.string  :name, null: false
      t.float   :rate, precision: 2, scale: 1
      t.string  :author_tip
      t.string  :budget
      t.string  :prep_time
      t.string  :author
      t.string  :difficulty
      t.integer :people_quantity
      t.string  :cook_time
      t.string  :total_time
      t.string  :image
      t.integer :nb_comments, default: 0
      
      t.timestamps
    end
  end
end
