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

ActiveRecord::Schema.define(version: 2022_05_17_082910) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_trgm"
  enable_extension "pgcrypto"
  enable_extension "plpgsql"
  enable_extension "unaccent"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
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
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "article_images", force: :cascade do |t|
    t.string "filename"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

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
    t.integer "reading_time", default: 0
    t.string "cached_user_username"
    t.bigint "rss_feed_id"
    t.index "user_id, title, digest(body_markdown, 'sha512'::text)", name: "index_articles_on_user_id_and_title_and_digest_body_markdown", unique: true
    t.index ["cached_tag_list"], name: "index_articles_on_cached_tag_list", opclass: :gin_trgm_ops, using: :gin
    t.index ["collection_id"], name: "index_articles_on_collection_id"
    t.index ["comment_score"], name: "index_articles_on_comment_score"
    t.index ["comments_count"], name: "index_articles_on_comments_count"
    t.index ["hotness_score", "comments_count"], name: "index_articles_on_hotness_score_and_comments_count"
    t.index ["path"], name: "index_articles_on_path"
    t.index ["public_reactions_count"], name: "index_articles_on_public_reactions_count", order: :desc
    t.index ["published"], name: "index_articles_on_published"
    t.index ["reading_list_document"], name: "index_articles_on_reading_list_document", using: :gin
    t.index ["rss_feed_id"], name: "index_articles_on_rss_feed_id"
    t.index ["slug", "user_id"], name: "index_articles_on_slug_and_user_id", unique: true
  end

  create_table "authors", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "author_type", default: 1, null: false
    t.string "website_url", null: false
    t.string "feed_url", null: false
    t.integer "nationality", default: 1, null: false
    t.datetime "feed_fetched_at", default: "2022-04-23 17:00:00"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["feed_url"], name: "index_authors_on_feed_url", unique: true
    t.index ["website_url"], name: "index_authors_on_website_url", unique: true
  end

  create_table "collections", force: :cascade do |t|
    t.string "slug"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["slug", "user_id"], name: "index_collections_on_slug_and_user_id", unique: true
    t.index ["user_id"], name: "index_collections_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource"
  end

  create_table "rss_feeds", force: :cascade do |t|
    t.bigint "author_id", null: false
    t.string "title", null: false
    t.string "feed_source_url", null: false
    t.datetime "published_at"
    t.string "cached_tag_list"
    t.boolean "translated", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "cached_author_name"
    t.index "((to_tsvector('simple'::regconfig, COALESCE((feed_source_url)::text, ''::text)) || to_tsvector('simple'::regconfig, COALESCE((title)::text, ''::text))))", name: "index_rss_feeds_on_search_fields_as_tsvector", using: :gin
    t.index ["author_id"], name: "index_rss_feeds_on_author_id"
    t.index ["cached_tag_list"], name: "index_rss_feeds_on_cached_tag_list", opclass: :gin_trgm_ops, using: :gin
    t.index ["title"], name: "index_rss_feeds_on_title"
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

  create_table "taggings", force: :cascade do |t|
    t.bigint "tag_id"
    t.string "taggable_type"
    t.bigint "taggable_id"
    t.string "tagger_type"
    t.bigint "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.string "tenant", limit: 128
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "taggings_taggable_context_idx"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type", "taggable_id"], name: "index_taggings_on_taggable_type_and_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
    t.index ["tagger_type", "tagger_id"], name: "index_taggings_on_tagger_type_and_tagger_id"
    t.index ["tenant"], name: "index_taggings_on_tenant"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
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
    t.integer "articles_count", default: 0, null: false
    t.string "username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "articles", "collections", on_delete: :nullify
  add_foreign_key "articles", "rss_feeds", on_delete: :nullify
  add_foreign_key "articles", "users", on_delete: :cascade
  add_foreign_key "collections", "users"
  add_foreign_key "rss_feeds", "authors", on_delete: :cascade
  add_foreign_key "taggings", "tags"
  create_trigger("update_reading_list_document", :generated => true, :compatibility => 1).
      on("articles").
      name("update_reading_list_document").
      before(:insert, :update).
      for_each(:row) do
    <<-SQL_ACTIONS
NEW.reading_list_document := 
  setweight(to_tsvector('simple'::regconfig, unaccent(coalesce(NEW.title, ''))), 'A') ||
  setweight(to_tsvector('simple'::regconfig, unaccent(coalesce(NEW.cached_tag_list, ''))), 'B') ||
  setweight(to_tsvector('simple'::regconfig, unaccent(coalesce(NEW.body_markdown, ''))), 'C') ||
  setweight(to_tsvector('simple'::regconfig, unaccent(coalesce(NEW.cached_user_name, ''))), 'D') ||
  setweight(to_tsvector('simple'::regconfig, unaccent(coalesce(NEW.cached_user_username, ''))), 'D');
    SQL_ACTIONS
  end

end
