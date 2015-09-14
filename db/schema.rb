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

ActiveRecord::Schema.define(version: 20150901212842) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_notes", force: :cascade do |t|
    t.string   "resource_id",     null: false
    t.string   "resource_type",   null: false
    t.integer  "admin_user_id"
    t.string   "admin_user_type"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_notes", ["admin_user_type", "admin_user_id"], name: "index_admin_notes_on_admin_user_type_and_admin_user_id", using: :btree
  add_index "admin_notes", ["resource_type", "resource_id"], name: "index_admin_notes_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "amas", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "start_date"
    t.string   "image_url"
    t.string   "video_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ama_type",    default: "monthly"
  end

  create_table "announcements", force: :cascade do |t|
    t.text     "body"
    t.boolean  "archived"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attachments", force: :cascade do |t|
    t.string   "url"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "authorizations", force: :cascade do |t|
    t.string  "uid"
    t.integer "user_id"
  end

  create_table "codes", force: :cascade do |t|
    t.string  "body"
    t.boolean "used", default: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "lesson_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ama_id"
    t.string   "ancestry"
    t.string   "comment_type", default: "regular"
  end

  add_index "comments", ["ama_id"], name: "index_comments_on_ama_id", using: :btree
  add_index "comments", ["ancestry"], name: "index_comments_on_ancestry", using: :btree
  add_index "comments", ["lesson_id"], name: "index_comments_on_lesson_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.datetime "start_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.string   "location"
    t.integer  "user_id"
    t.string   "color"
    t.string   "url"
  end

  add_index "events", ["user_id"], name: "index_events_on_user_id", using: :btree

  create_table "lessons", force: :cascade do |t|
    t.string   "lesson_type"
    t.boolean  "video"
    t.boolean  "started",      default: false
    t.boolean  "finished",     default: false
    t.string   "video_uid"
    t.string   "video_title"
    t.string   "video_author"
    t.text     "body"
    t.boolean  "discussion"
    t.text     "description"
    t.integer  "track_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order"
    t.string   "video_length"
    t.string   "slug"
  end

  add_index "lessons", ["track_id"], name: "index_lessons_on_track_id", using: :btree

  create_table "progresses", force: :cascade do |t|
    t.integer  "model_id"
    t.string   "model_type"
    t.integer  "percent_complete"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "progresses", ["model_id"], name: "index_progresses_on_model_id", using: :btree
  add_index "progresses", ["user_id"], name: "index_progresses_on_user_id", using: :btree

  create_table "skills", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree

  create_table "tags", force: :cascade do |t|
    t.string "name"
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "topics", force: :cascade do |t|
    t.string  "icon"
    t.string  "name"
    t.integer "percent_complete"
    t.integer "order"
    t.text    "body"
    t.boolean "free",             default: false
    t.text    "summary"
    t.string  "video_uid"
    t.string  "slug"
  end

  create_table "tracks", force: :cascade do |t|
    t.integer "order"
    t.string  "name"
    t.string  "icon"
    t.string  "percent_complete"
    t.integer "topic_id"
    t.integer "watch_time"
    t.text    "summary"
    t.string  "video_uid"
    t.string  "slug"
  end

  add_index "tracks", ["topic_id"], name: "index_tracks_on_topic_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.text     "bio"
    t.string   "twitter"
    t.string   "facebook"
    t.string   "program"
    t.string   "linkedin"
    t.string   "street_address"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "zip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  default: ""
    t.string   "encrypted_password",     default: "",          null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "team"
    t.string   "skype"
    t.string   "gmail"
    t.string   "slug"
    t.float    "latitude",               default: 37.5638
    t.float    "longitude",              default: -122.325192
    t.string   "employment"
    t.string   "instagram"
    t.string   "angellist"
    t.string   "dribbble"
    t.string   "github"
    t.integer  "ncounter"
    t.boolean  "eventReminder",          default: false
    t.integer  "pcounter"
    t.integer  "bonus_credits"
    t.integer  "bonus_points_earned"
    t.integer  "char_points"
    t.string   "role"
    t.integer  "timezone"
    t.string   "title",                  default: "Recruit"
    t.boolean  "paid",                   default: false
    t.string   "subscription"
    t.string   "customer_id"
    t.integer  "karma",                  default: 0
    t.string   "plan"
    t.string   "color",                  default: "#414141"
    t.boolean  "show_topic_tutorial",    default: true
    t.boolean  "show_track_tutorial",    default: true
    t.string   "profile_pic_url"
    t.string   "username"
    t.string   "full_name"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["slug"], name: "index_users_on_slug", using: :btree

  create_table "votes", force: :cascade do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope", using: :btree
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope", using: :btree

end
