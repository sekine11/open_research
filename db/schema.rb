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

ActiveRecord::Schema.define(version: 2020_05_14_082921) do

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
  end

  create_table "discuss_comments", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "discussion_id", null: false
    t.string "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discussion_id"], name: "index_discuss_comments_on_discussion_id"
    t.index ["user_id"], name: "index_discuss_comments_on_user_id"
  end

  create_table "discuss_favorites", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "discussion_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discussion_id"], name: "index_discuss_favorites_on_discussion_id"
    t.index ["user_id"], name: "index_discuss_favorites_on_user_id"
  end

  create_table "discussions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "subject", null: false
    t.text "content", null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_discussions_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "laboratory_id", null: false
    t.string "title", null: false
    t.datetime "start", null: false
    t.datetime "end", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["laboratory_id"], name: "index_events_on_laboratory_id"
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "lab_information_checks", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "lab_information_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lab_information_id"], name: "index_lab_information_checks_on_lab_information_id"
    t.index ["user_id"], name: "index_lab_information_checks_on_user_id"
  end

  create_table "lab_information_comments", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "lab_information_id", null: false
    t.string "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lab_information_id"], name: "index_lab_information_comments_on_lab_information_id"
    t.index ["user_id"], name: "index_lab_information_comments_on_user_id"
  end

  create_table "lab_informations", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "laboratory_id", null: false
    t.string "subject", null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["laboratory_id"], name: "index_lab_informations_on_laboratory_id"
    t.index ["user_id"], name: "index_lab_informations_on_user_id"
  end

  create_table "lab_members", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "laboratory_id", null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["laboratory_id"], name: "index_lab_members_on_laboratory_id"
    t.index ["user_id"], name: "index_lab_members_on_user_id"
  end

  create_table "lab_tasks", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "laboratory_id", null: false
    t.string "content", null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["laboratory_id"], name: "index_lab_tasks_on_laboratory_id"
    t.index ["user_id"], name: "index_lab_tasks_on_user_id"
  end

  create_table "laboratories", force: :cascade do |t|
    t.string "name", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_laboratories_on_user_id"
  end

  create_table "project_information_checks", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "poject_information_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["poject_information_id"], name: "index_project_information_checks_on_poject_information_id"
    t.index ["user_id"], name: "index_project_information_checks_on_user_id"
  end

  create_table "project_information_comments", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "project_information_id", null: false
    t.string "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_information_id"], name: "index_project_information_comments_on_project_information_id"
    t.index ["user_id"], name: "index_project_information_comments_on_user_id"
  end

  create_table "project_informations", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "project_id", null: false
    t.string "subject", null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_project_informations_on_project_id"
    t.index ["user_id"], name: "index_project_informations_on_user_id"
  end

  create_table "project_members", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "project_id", null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_project_members_on_project_id"
    t.index ["user_id"], name: "index_project_members_on_user_id"
  end

  create_table "project_tasks", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "project_id", null: false
    t.string "content", null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_project_tasks_on_project_id"
    t.index ["user_id"], name: "index_project_tasks_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "laboratory_id", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["laboratory_id"], name: "index_projects_on_laboratory_id"
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "protocol_favorites", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "protocol_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["protocol_id"], name: "index_protocol_favorites_on_protocol_id"
    t.index ["user_id"], name: "index_protocol_favorites_on_user_id"
  end

  create_table "protocols", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "subject", null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_protocols_on_user_id"
  end

  create_table "ques_comments", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "question_id", null: false
    t.string "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_ques_comments_on_question_id"
    t.index ["user_id"], name: "index_ques_comments_on_user_id"
  end

  create_table "ques_favorites", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "question_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_ques_favorites_on_question_id"
    t.index ["user_id"], name: "index_ques_favorites_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "subject", null: false
    t.text "content", null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_questions_on_user_id"
  end

  create_table "taggings", force: :cascade do |t|
    t.integer "tag_id"
    t.string "taggable_type"
    t.integer "taggable_id"
    t.string "tagger_type"
    t.integer "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "taggings_taggable_context_idx"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "public_name", null: false
    t.string "private_name", null: false
    t.string "image_id"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "status", default: true, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
