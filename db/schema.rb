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

ActiveRecord::Schema.define(version: 20171025085931) do

  create_table "about_image_translations", force: :cascade do |t|
    t.integer  "about_image_id", limit: 4,   null: false
    t.string   "locale",         limit: 255, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "image_caption",  limit: 255
    t.string   "image_credit",   limit: 255
  end

  add_index "about_image_translations", ["about_image_id"], name: "index_about_image_translations_on_about_image_id", using: :btree
  add_index "about_image_translations", ["locale"], name: "index_about_image_translations_on_locale", using: :btree

  create_table "about_images", force: :cascade do |t|
    t.integer  "position",              limit: 1,   default: 0
    t.integer  "sort_order",            limit: 1,   default: 0
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.string   "image_en_file_name",    limit: 255
    t.string   "image_en_content_type", limit: 255
    t.integer  "image_en_file_size",    limit: 4
    t.datetime "image_en_updated_at"
    t.string   "image_ru_file_name",    limit: 255
    t.string   "image_ru_content_type", limit: 255
    t.integer  "image_ru_file_size",    limit: 4
    t.datetime "image_ru_updated_at"
  end

  add_index "about_images", ["position", "sort_order"], name: "index_about_images_on_position_and_sort_order", using: :btree

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",    limit: 255, null: false
    t.string   "data_content_type", limit: 255
    t.integer  "data_file_size",    limit: 4
    t.string   "data_fingerprint",  limit: 255
    t.string   "type",              limit: 30
    t.integer  "width",             limit: 4
    t.integer  "height",            limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "ckeditor_assets", ["type"], name: "index_ckeditor_assets_on_type", using: :btree

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",           limit: 255, null: false
    t.integer  "sluggable_id",   limit: 4,   null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope",          limit: 255
    t.string   "locale",         limit: 255
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["locale"], name: "index_friendly_id_slugs_on_locale", using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type", "locale"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_locale", length: {"slug"=>140, "sluggable_type"=>nil, "locale"=>2}, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope", "locale"], name: "index_friendly_id_slugs_uniqueness", unique: true, length: {"slug"=>70, "sluggable_type"=>nil, "scope"=>70, "locale"=>2}, using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "page_content_translations", force: :cascade do |t|
    t.integer  "page_content_id", limit: 4,     null: false
    t.string   "locale",          limit: 255,   null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "title",           limit: 255
    t.text     "content",         limit: 65535
  end

  add_index "page_content_translations", ["locale"], name: "index_page_content_translations_on_locale", using: :btree
  add_index "page_content_translations", ["page_content_id"], name: "index_page_content_translations_on_page_content_id", using: :btree

  create_table "page_contents", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stories", force: :cascade do |t|
    t.boolean  "is_published",                            default: false
    t.date     "published_at"
    t.string   "slug",                        limit: 255
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
    t.string   "image_homepage_file_name",    limit: 255
    t.string   "image_homepage_content_type", limit: 255
    t.integer  "image_homepage_file_size",    limit: 4
    t.datetime "image_homepage_updated_at"
    t.string   "image_story_file_name",       limit: 255
    t.string   "image_story_content_type",    limit: 255
    t.integer  "image_story_file_size",       limit: 4
    t.datetime "image_story_updated_at"
    t.integer  "sort_order",                  limit: 1,   default: 1
    t.boolean  "is_wide",                                 default: false
    t.string   "image_share_en_file_name",    limit: 255
    t.string   "image_share_en_content_type", limit: 255
    t.integer  "image_share_en_file_size",    limit: 4
    t.datetime "image_share_en_updated_at"
    t.string   "image_share_ru_file_name",    limit: 255
    t.string   "image_share_ru_content_type", limit: 255
    t.integer  "image_share_ru_file_size",    limit: 4
    t.datetime "image_share_ru_updated_at"
  end

  add_index "stories", ["is_published", "published_at"], name: "index_stories_on_is_published_and_published_at", using: :btree
  add_index "stories", ["slug"], name: "index_stories_on_slug", unique: true, using: :btree
  add_index "stories", ["sort_order"], name: "index_stories_on_sort_order", using: :btree

  create_table "story_translations", force: :cascade do |t|
    t.integer  "story_id",            limit: 4,     null: false
    t.string   "locale",              limit: 255,   null: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "title",               limit: 255
    t.text     "content",             limit: 65535
    t.string   "author",              limit: 255
    t.string   "image_caption",       limit: 255
    t.string   "image_credit",        limit: 255
    t.string   "slug",                limit: 255
    t.string   "title_share",         limit: 255
    t.string   "description_share",   limit: 255
    t.string   "title_home",          limit: 255
    t.string   "author_organization", limit: 255
    t.string   "subheader",           limit: 255
    t.text     "footnotes",           limit: 65535
  end

  add_index "story_translations", ["locale"], name: "index_story_translations_on_locale", using: :btree
  add_index "story_translations", ["slug"], name: "index_story_translations_on_slug", using: :btree
  add_index "story_translations", ["story_id"], name: "index_story_translations_on_story_id", using: :btree
  add_index "story_translations", ["title"], name: "index_story_translations_on_title", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role_id",                limit: 4
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["role_id"], name: "index_users_on_role_id", using: :btree

end
