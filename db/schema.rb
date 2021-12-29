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

ActiveRecord::Schema.define(version: 2014_07_19_033951) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_trgm"
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "title"
    t.string "slug"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "categories_posts", id: false, force: :cascade do |t|
    t.integer "category_id"
    t.integer "post_id"
    t.index ["category_id"], name: "index_categories_posts_on_category_id"
    t.index ["post_id"], name: "index_categories_posts_on_post_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text "body"
    t.integer "author_id"
    t.integer "post_id"
    t.datetime "updated_at", null: false
    t.datetime "created_at", null: false
    t.integer "lock_version", default: 0, null: false
    t.index ["author_id"], name: "index_comments_on_author_id"
    t.index ["post_id"], name: "index_comments_on_post_id"
  end

  create_table "images", force: :cascade do |t|
    t.string "file"
    t.datetime "updated_at", null: false
    t.datetime "created_at", null: false
    t.integer "lock_version", default: 0, null: false
  end

  create_table "posts", force: :cascade do |t|
    t.string "subject"
    t.text "body"
    t.integer "author_id"
    t.datetime "updated_at", null: false
    t.datetime "created_at", null: false
    t.integer "lock_version", default: 0, null: false
    t.integer "status_id"
    t.boolean "pinned", default: false, null: false
    t.string "slug"
    t.index "to_tsvector('english'::regconfig, (subject)::text)", name: "posts_to_tsvector_idx", using: :gin
    t.index "to_tsvector('english'::regconfig, body)", name: "posts_to_tsvector_idx1", using: :gin
    t.index ["author_id"], name: "index_posts_on_author_id"
    t.index ["status_id"], name: "index_posts_on_status_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "updated_at", null: false
    t.datetime "created_at", null: false
    t.integer "lock_version", default: 0, null: false
    t.boolean "admin", default: false
    t.integer "status_id", default: 0
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

end
