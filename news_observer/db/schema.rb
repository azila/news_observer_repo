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

ActiveRecord::Schema.define(version: 20140915163616) do

  create_table "admin_users", force: true do |t|
    t.string   "first_name",      limit: 25
    t.string   "last_name",       limit: 50
    t.string   "email",           limit: 100
    t.string   "username",        limit: 25
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["username"], name: "index_admin_users_on_username", using: :btree

  create_table "admin_users_categories", id: false, force: true do |t|
    t.integer "admin_user_id"
    t.integer "category_id"
  end

  add_index "admin_users_categories", ["admin_user_id", "category_id"], name: "index_admin_users_categories_on_admin_user_id_and_category_id", using: :btree

  create_table "article_edits", force: true do |t|
    t.integer  "admin_user_id"
    t.integer  "article_id"
    t.string   "summary"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "article_edits", ["admin_user_id", "article_id"], name: "index_article_edits_on_admin_user_id_and_article_id", using: :btree

  create_table "articles", force: true do |t|
    t.integer  "category_id"
    t.string   "name"
    t.integer  "position"
    t.boolean  "visible",      default: false
    t.string   "content_type"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "articles", ["category_id"], name: "index_articles_on_category_id", using: :btree

  create_table "categories", force: true do |t|
    t.integer  "newspaper_id"
    t.string   "name"
    t.string   "permalink"
    t.integer  "position"
    t.boolean  "visible",      default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["newspaper_id"], name: "index_categories_on_newspaper_id", using: :btree
  add_index "categories", ["permalink"], name: "index_categories_on_permalink", using: :btree

  create_table "newspapers", force: true do |t|
    t.string   "name"
    t.integer  "position"
    t.boolean  "visible",    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
