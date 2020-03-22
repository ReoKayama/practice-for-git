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

ActiveRecord::Schema.define(version: 20200216040019) do

  create_table "favorites", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "lec_id"
    t.text "fav_day"
    t.integer "fav_period"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "lectures", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "t_quarter"
    t.text "t_day"
    t.integer "t_period"
    t.text "group"
    t.text "en_major"
    t.integer "en_grade"
    t.text "ev_method"
    t.text "ev_attendance"
    t.float "ev_understanding"
    t.float "ev_score"
    t.float "ev_interest"
    t.text "ev_getting"
    t.text "professor"
    t.text "lec_name"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "lecture_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "understanding"
    t.integer "getting"
    t.integer "interest"
    t.integer "score"
    t.text "tokutan"
    t.text "attendance"
    t.text "method"
    t.text "comment"
    t.index ["lecture_id"], name: "index_reviews_on_lecture_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.string "name"
    t.string "password_digest"
    t.integer "grade"
    t.text "major"
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
