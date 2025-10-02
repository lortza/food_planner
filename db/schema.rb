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

ActiveRecord::Schema[7.2].define(version: 2025_10_02_174907) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", precision: nil, null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "aisles", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "order_number"
    t.index ["user_id"], name: "index_aisles_on_user_id"
  end

  create_table "experimental_recipes", force: :cascade do |t|
    t.string "title"
    t.string "source_url"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_url"
    t.index ["user_id"], name: "index_experimental_recipes_on_user_id"
  end

  create_table "ingredients", force: :cascade do |t|
    t.bigint "recipe_id"
    t.float "quantity", default: 0.0, null: false
    t.string "measurement_unit", default: "", null: false
    t.string "name", default: "", null: false
    t.string "preparation_style", default: "", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["recipe_id"], name: "index_ingredients_on_recipe_id"
  end

  create_table "inventories", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.text "items"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_inventories_on_user_id"
  end

  create_table "meal_plan_recipes", force: :cascade do |t|
    t.bigint "meal_plan_id"
    t.bigint "recipe_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["meal_plan_id"], name: "index_meal_plan_recipes_on_meal_plan_id"
    t.index ["recipe_id"], name: "index_meal_plan_recipes_on_recipe_id"
  end

  create_table "meal_plans", force: :cascade do |t|
    t.date "prepared_on", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "people_served", default: 0, null: false
    t.bigint "user_id"
    t.text "notes"
    t.index ["user_id"], name: "index_meal_plans_on_user_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.string "title", default: "", null: false
    t.string "source_name", default: "", null: false
    t.string "source_url", default: "", null: false
    t.integer "servings", default: 0, null: false
    t.text "instructions", default: "", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "prep_time", default: 0, null: false
    t.integer "cook_time", default: 0, null: false
    t.string "image_url", default: "", null: false
    t.integer "reheat_time", default: 0
    t.string "pepperplate_url"
    t.text "notes"
    t.boolean "archived", default: false
    t.bigint "user_id"
    t.text "reheat_instructions", default: ""
    t.text "prep_day_instructions", default: ""
    t.string "extra_work_note"
    t.date "last_prepared_on"
    t.text "nutrition_data_iframe"
    t.integer "status", default: 1, null: false
    t.index ["status"], name: "index_recipes_on_status"
    t.index ["user_id"], name: "index_recipes_on_user_id"
  end

  create_table "scheduled_deliveries", force: :cascade do |t|
    t.datetime "scheduled_for", precision: nil
    t.string "service_provider"
    t.bigint "shopping_list_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shopping_list_id"], name: "index_scheduled_deliveries_on_shopping_list_id"
  end

  create_table "shopping_list_items", force: :cascade do |t|
    t.bigint "shopping_list_id"
    t.bigint "aisle_id"
    t.float "quantity"
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "recurrence_frequency"
    t.float "recurrence_quantity", default: 0.0
    t.string "heb_upc"
    t.string "status", null: false
    t.index ["aisle_id"], name: "index_shopping_list_items_on_aisle_id"
    t.index ["shopping_list_id"], name: "index_shopping_list_items_on_shopping_list_id"
  end

  create_table "shopping_lists", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "favorite", default: false
    t.boolean "main", default: false
    t.index ["user_id"], name: "index_shopping_lists_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "aisles", "users"
  add_foreign_key "experimental_recipes", "users"
  add_foreign_key "ingredients", "recipes"
  add_foreign_key "inventories", "users"
  add_foreign_key "meal_plan_recipes", "meal_plans"
  add_foreign_key "meal_plan_recipes", "recipes"
  add_foreign_key "meal_plans", "users"
  add_foreign_key "recipes", "users"
  add_foreign_key "scheduled_deliveries", "shopping_lists"
  add_foreign_key "shopping_list_items", "aisles"
  add_foreign_key "shopping_list_items", "shopping_lists"
  add_foreign_key "shopping_lists", "users"
end
