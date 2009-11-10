# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20091110064756) do

  create_table "brands", :force => true do |t|
    t.string   "name"
    t.string   "logo_file_name"
    t.string   "string"
    t.string   "logo_content_type"
    t.string   "logo_file_size"
    t.string   "integer"
    t.string   "logo_updated_at"
    t.string   "datetime"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "guid"
  end

  create_table "carts", :force => true do |t|
    t.integer  "user_id"
    t.string   "cart_token", :limit => 40
    t.string   "aasm_state", :limit => 30, :default => "new"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.string   "guid"
  end

  create_table "categorizations", :force => true do |t|
    t.integer  "category_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categorizations", ["category_id"], :name => "index_categorizations_on_category_id"
  add_index "categorizations", ["product_id"], :name => "index_categorizations_on_product_id"

  create_table "colors", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "hex_value"
    t.string   "guid"
  end

  create_table "garment_sizes", :force => true do |t|
    t.string   "name"
    t.string   "sku"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "gender"
    t.string   "guid"
  end

  create_table "line_items", :force => true do |t|
    t.integer  "variation_id"
    t.integer  "cart_id"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "price"
  end

  create_table "products", :force => true do |t|
    t.string   "name"
    t.text     "full_description"
    t.float    "price"
    t.string   "title"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.integer  "brand_id"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "guid"
  end

  create_table "roles", :force => true do |t|
    t.string "name"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  add_index "roles_users", ["role_id"], :name => "index_roles_users_on_role_id"
  add_index "roles_users", ["user_id"], :name => "index_roles_users_on_user_id"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type"], :name => "index_taggings_on_taggable_id_and_taggable_type"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
    t.string   "state",                                    :default => "passive"
    t.datetime "deleted_at"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

  create_table "variations", :force => true do |t|
    t.integer  "product_id"
    t.integer  "color_id"
    t.integer  "garment_size_id"
    t.string   "sku"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "variations", ["color_id"], :name => "index_variations_on_color_id"
  add_index "variations", ["garment_size_id"], :name => "index_variations_on_garment_size_id"
  add_index "variations", ["product_id"], :name => "index_variations_on_product_id"

end
