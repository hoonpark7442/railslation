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

ActiveRecord::Schema.define(version: 2022_04_23_091818) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_trgm"
  enable_extension "pgcrypto"
  enable_extension "plpgsql"
  enable_extension "unaccent"

  create_table "articles", force: :cascade do |t|
    t.text "body_markdown"
    t.string "cached_tag_list"
    t.text "cached_user"
    t.string "cached_user_name"
    t.bigint "collection_id"
    t.integer "comment_score", default: 0
    t.integer "comments_count", default: 0, null: false
    t.string "description"
    t.datetime "edited_at"
    t.integer "featured_number"
    t.integer "hotness_score", default: 0
    t.datetime "last_comment_at", default: "2022-04-23 17:00:00"
    t.integer "nth_published_by_author", default: 0
    t.integer "page_views_count", default: 0
    t.string "password"
    t.string "path"
    t.text "processed_html"
    t.integer "public_reactions_count", default: 0, null: false
    t.boolean "published", default: false
    t.datetime "published_at"
    t.integer "reactions_count", default: 0, null: false
    t.tsvector "reading_list_document"
    t.integer "score", default: 0
    t.text "slug"
    t.string "title"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index "user_id, title, digest(body_markdown, 'sha512'::text)", name: "index_articles_on_user_id_and_title_and_digest_body_markdown", unique: true
    t.index ["cached_tag_list"], name: "index_articles_on_cached_tag_list", opclass: :gin_trgm_ops, using: :gin
    t.index ["collection_id"], name: "index_articles_on_collection_id"
    t.index ["comment_score"], name: "index_articles_on_comment_score"
    t.index ["comments_count"], name: "index_articles_on_comments_count"
    t.index ["hotness_score", "comments_count"], name: "index_articles_on_hotness_score_and_comments_count"
    t.index ["path"], name: "index_articles_on_path"
    t.index ["public_reactions_count"], name: "index_articles_on_public_reactions_count", order: :desc
    t.index ["reading_list_document"], name: "index_articles_on_reading_list_document", using: :gin
    t.index ["slug", "user_id"], name: "index_articles_on_slug_and_user_id", unique: true
  end

  create_table "settings_authentications", force: :cascade do |t|
    t.string "var", null: false
    t.text "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["var"], name: "index_settings_authentications_on_var", unique: true
  end

  create_table "site_configs", force: :cascade do |t|
    t.string "var", null: false
    t.text "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["var"], name: "index_site_configs_on_var", unique: true
  end

  create_table "social_auths", force: :cascade do |t|
    t.string "provider", null: false
    t.string "uid", null: false
    t.string "email"
    t.string "image"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_social_auths_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "name"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
