# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150815083156) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"

  create_table "brands", force: :cascade do |t|
    t.string   "name"
    t.string   "chinese_name"
    t.string   "logo_uid"
    t.integer  "logo_width"
    t.integer  "logo_height"
    t.integer  "logo_size"
    t.string   "banner_uid"
    t.integer  "banner_width"
    t.integer  "banner_height"
    t.integer  "banner_size"
    t.string   "marker_uid"
    t.integer  "marker_width"
    t.integer  "marker_height"
    t.integer  "marker_size"
    t.text     "summary"
    t.text     "description"
    t.integer  "established"
    t.string   "website"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "brands_posts", id: false, force: :cascade do |t|
    t.integer "brand_id"
    t.integer "post_id"
  end

  add_index "brands_posts", ["brand_id", "post_id"], name: "index_brands_posts_on_brand_id_and_post_id", unique: true
  add_index "brands_posts", ["post_id"], name: "index_brands_posts_on_post_id"

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_uid",                  null: false
    t.string   "data_name",                 null: false
    t.string   "data_mime_type"
    t.integer  "data_size"
    t.integer  "assetable_id"
    t.string   "assetable_type", limit: 30
    t.string   "type",           limit: 30
    t.integer  "data_width"
    t.integer  "data_height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type"

  create_table "establishments", force: :cascade do |t|
    t.string   "label"
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "brand_id"
    t.string   "establishment_type"
    t.string   "picture_uid"
    t.integer  "picture_width"
    t.integer  "picture_height"
    t.integer  "picture_size"
    t.string   "static_map_uid"
    t.integer  "static_map_width"
    t.integer  "static_map_height"
    t.integer  "static_map_size"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "itineraries", force: :cascade do |t|
    t.string   "title"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "itineraries", ["user_id"], name: "index_itineraries_on_user_id"

  create_table "photos", force: :cascade do |t|
    t.string   "image_uid"
    t.string   "title"
    t.integer  "image_width"
    t.integer  "image_height"
    t.integer  "image_size"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.text     "summary"
    t.integer  "photo_id"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.date     "published_at"
  end

  add_index "posts", ["user_id"], name: "index_posts_on_user_id"

  create_table "stops", force: :cascade do |t|
    t.integer  "itinerary_id"
    t.integer  "establishment_id"
    t.integer  "order"
    t.text     "description"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "stops", ["establishment_id", "itinerary_id"], name: "idx_establishments_itineraries_uniq", unique: true
  add_index "stops", ["itinerary_id"], name: "index_stops_on_itinerary_id"

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "avatar_uid"
    t.string   "name"
    t.string   "username",               default: "",    null: false
    t.boolean  "superadmin",             default: false, null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["username"], name: "index_users_on_username", unique: true

  create_table "votes", force: :cascade do |t|
    t.boolean  "vote",          default: false, null: false
    t.integer  "voteable_id",                   null: false
    t.string   "voteable_type",                 null: false
    t.integer  "voter_id"
    t.string   "voter_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["voteable_id", "voteable_type"], name: "index_votes_on_voteable_id_and_voteable_type"
  add_index "votes", ["voter_id", "voter_type", "voteable_id", "voteable_type"], name: "fk_one_vote_per_user_per_entity", unique: true
  add_index "votes", ["voter_id", "voter_type"], name: "index_votes_on_voter_id_and_voter_type"

end
