# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_09_27_161431) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ingredients", force: :cascade do |t|
    t.bigint "recipe_id", null: false
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "optional", default: false
    t.tsvector "tsv_name"
    t.index ["recipe_id"], name: "index_ingredients_on_recipe_id"
    t.index ["tsv_name"], name: "index_ingredients_on_tsv_name", using: :gin
  end

  create_table "recipes", force: :cascade do |t|
    t.string "name", null: false
    t.float "rate"
    t.string "author_tip"
    t.string "budget"
    t.string "prep_time"
    t.string "author"
    t.string "difficulty"
    t.integer "people_quantity"
    t.string "cook_time"
    t.string "total_time"
    t.string "image"
    t.integer "nb_comments", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "mandatory_ingredients_count", default: 0
    t.string "slug", null: false
    t.index ["people_quantity"], name: "index_recipes_on_people_quantity"
    t.index ["total_time"], name: "index_recipes_on_total_time"
  end

  create_table "recipes_tags", id: false, force: :cascade do |t|
    t.bigint "recipe_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["recipe_id", "tag_id"], name: "index_recipes_tags_on_recipe_id_and_tag_id"
    t.index ["tag_id", "recipe_id"], name: "index_recipes_tags_on_tag_id_and_recipe_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "ingredients", "recipes"
end
