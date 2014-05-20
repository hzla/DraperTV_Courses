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

ActiveRecord::Schema.define(version: 20140515195804) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: true do |t|
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_admin_notes_on_resource_type_and_resource_id", using: :btree

  create_table "activities", force: true do |t|
    t.integer  "user_id"
    t.string   "action"
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "activities", ["trackable_id"], name: "index_activities_on_trackable_id", using: :btree
  add_index "activities", ["user_id"], name: "index_activities_on_user_id", using: :btree

  create_table "activity_feeds", force: true do |t|
    t.integer  "user_id"
    t.string   "action"
    t.integer  "tobetrackable_id"
    t.string   "tobetrackable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activity_feeds", ["tobetrackable_id"], name: "index_activity_feeds_on_tobetrackable_id", using: :btree
  add_index "activity_feeds", ["user_id"], name: "index_activity_feeds_on_user_id", using: :btree

  create_table "admin_users", force: true do |t|
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "apps", force: true do |t|
    t.string   "first"
    t.string   "last"
    t.string   "email"
    t.string   "phone"
    t.text     "exist"
    t.text     "business"
    t.string   "dob"
    t.string   "college"
    t.string   "media"
    t.string   "gender"
    t.string   "street_address"
    t.string   "postal_code"
    t.string   "state"
    t.string   "country"
    t.string   "marketing"
    t.string   "technical"
    t.string   "city"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "response"
    t.string   "status"
    t.boolean  "payment"
    t.text     "notes"
  end

  create_table "assignments", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "vimeo_url"
    t.string   "preview_url"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.integer  "course_id"
    t.integer  "order_id",                 default: 0
    t.integer  "survey_id"
    t.boolean  "require_upload",           default: false
    t.string   "speaker_name"
    t.text     "speaker_bio"
    t.string   "speaker_linkedin"
    t.string   "speaker_twitter"
    t.string   "speaker_angel"
    t.string   "category"
    t.string   "speaker_pic_file_name"
    t.string   "speaker_pic_content_type"
    t.integer  "speaker_pic_file_size"
    t.datetime "speaker_pic_updated_at"
    t.string   "slug"
    t.integer  "points"
    t.integer  "user_assignment_id"
    t.string   "question_text"
    t.text     "question_duh_response"
    t.boolean  "active"
    t.boolean  "business"
  end

  add_index "assignments", ["slug"], name: "index_assignments_on_slug", using: :btree

  create_table "attachments", force: true do |t|
    t.string   "url"
    t.string   "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "authorships", force: true do |t|
    t.integer  "user_id"
    t.integer  "skill_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "authorships", ["skill_id"], name: "index_authorships_on_skill_id", using: :btree
  add_index "authorships", ["user_id"], name: "index_authorships_on_user_id", using: :btree

  create_table "badges", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "course_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "icon_file_name"
    t.string   "icon_content_type"
    t.integer  "icon_file_size"
    t.datetime "icon_updated_at"
  end

  create_table "bucketlist_items", force: true do |t|
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "user_id"
    t.integer  "bucketlist_id"
    t.string   "title"
    t.text     "body"
    t.boolean  "complete"
  end

  create_table "bucketlists", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  create_table "calendars", force: true do |t|
    t.string   "name"
    t.datetime "start_time"
    t.text     "description"
    t.string   "location"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "ckeditor_assets", force: true do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "courses", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "course_icon_file_name"
    t.string   "course_icon_content_type"
    t.integer  "course_icon_file_size"
    t.datetime "course_icon_updated_at"
    t.string   "intro_screenshot_file_name"
    t.string   "intro_screenshot_content_type"
    t.integer  "intro_screenshot_file_size"
    t.datetime "intro_screenshot_updated_at"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "length"
    t.string   "intro_vimeo"
    t.string   "badge_vimeo"
    t.string   "tile_image_file_name"
    t.string   "tile_image_content_type"
    t.integer  "tile_image_file_size"
    t.datetime "tile_image_updated_at"
    t.string   "slug"
  end

  add_index "courses", ["slug"], name: "index_courses_on_slug", unique: true, using: :btree

  create_table "delayed_jobs", force: true do |t|
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

  create_table "events", force: true do |t|
    t.string   "name"
    t.datetime "start_time"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.text     "description"
    t.string   "location"
    t.integer  "user_id"
  end

  add_index "events", ["user_id"], name: "index_events_on_user_id", using: :btree

  create_table "feedbacks", force: true do |t|
    t.string   "type"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: true do |t|
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  create_table "milestones", force: true do |t|
    t.text     "vision"
    t.text     "creativity"
    t.text     "speedstrength"
    t.text     "evangelism"
    t.text     "power"
    t.text     "survival"
    t.text     "brilliance"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "posts", force: true do |t|
    t.text     "content"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.integer  "user_id"
    t.string   "category"
    t.string   "privacy"
    t.string   "title"
    t.string   "slug"
    t.integer  "vote"
  end

  add_index "posts", ["slug"], name: "index_posts_on_slug", using: :btree

  create_table "resources", force: true do |t|
    t.string   "title"
    t.string   "url"
    t.text     "description"
    t.string   "category"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "skills", force: true do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "survey_answers", force: true do |t|
    t.integer  "attempt_id"
    t.integer  "question_id"
    t.integer  "option_id"
    t.boolean  "correct"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "survey_attempts", force: true do |t|
    t.integer "participant_id"
    t.string  "participant_type"
    t.integer "survey_id"
    t.boolean "winner"
    t.integer "score"
  end

  create_table "survey_options", force: true do |t|
    t.integer  "question_id"
    t.integer  "weight",      default: 0
    t.string   "text"
    t.boolean  "correct"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "survey_questions", force: true do |t|
    t.integer  "survey_id"
    t.string   "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "survey_surveys", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "attempts_number", default: 0
    t.boolean  "finished",        default: false
    t.boolean  "active",          default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree

  create_table "tags", force: true do |t|
    t.string "name"
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "user_assignments", force: true do |t|
    t.text     "text"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "upload_file_name"
    t.string   "upload_content_type"
    t.integer  "upload_file_size"
    t.datetime "upload_updated_at"
    t.integer  "user_id"
    t.integer  "assignment_id"
    t.string   "link"
    t.integer  "point_value"
    t.integer  "bonus_points_given"
    t.integer  "rating"
    t.text     "question_response"
    t.boolean  "complete",            default: false
    t.boolean  "editcheck"
  end

  create_table "user_comments", force: true do |t|
    t.text     "content"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "user_comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type", using: :btree

  create_table "users", force: true do |t|
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
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.string   "email",                  default: "",          null: false
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
    t.string   "online",                 default: "online"
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
    t.integer  "pcounter"
    t.integer  "bonus_credits"
    t.integer  "bonus_points_earned"
    t.boolean  "eventReminder",          default: false
    t.string   "role"
    t.integer  "char_points"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["slug"], name: "index_users_on_slug", using: :btree

  create_table "videos", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "vimeo_url"
    t.string   "preview_url"
    t.integer  "order_id"
    t.string   "speaker_name"
    t.text     "speaker_bio"
    t.string   "speaker_linkedin"
    t.string   "speaker_twitter"
    t.string   "speaker_angel"
    t.string   "category"
    t.string   "slug"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "speaker_pic_file_name"
    t.string   "speaker_pic_content_type"
    t.integer  "speaker_pic_file_size"
    t.datetime "speaker_pic_updated_at"
    t.string   "video_pic_file_name"
    t.string   "video_pic_content_type"
    t.integer  "video_pic_file_size"
    t.datetime "video_pic_updated_at"
  end

  create_table "votes", force: true do |t|
    t.boolean  "vote",          default: false, null: false
    t.integer  "voteable_id",                   null: false
    t.string   "voteable_type",                 null: false
    t.integer  "voter_id"
    t.string   "voter_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["voteable_id", "voteable_type"], name: "index_votes_on_voteable_id_and_voteable_type", using: :btree
  add_index "votes", ["voter_id", "voter_type", "voteable_id", "voteable_type"], name: "fk_one_vote_per_user_per_entity", unique: true, using: :btree
  add_index "votes", ["voter_id", "voter_type"], name: "index_votes_on_voter_id_and_voter_type", using: :btree

end
