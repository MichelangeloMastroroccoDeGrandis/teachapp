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

ActiveRecord::Schema[8.1].define(version: 2026_07_26_084753) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "courses", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.bigint "instructor_id", null: false
    t.decimal "price", precision: 8, scale: 2, default: "0.0"
    t.boolean "published", default: false, null: false
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.index ["instructor_id"], name: "index_courses_on_instructor_id"
  end

  create_table "enrollments", force: :cascade do |t|
    t.bigint "course_id", null: false
    t.datetime "created_at", null: false
    t.datetime "enrolled_at", default: -> { "CURRENT_TIMESTAMP" }
    t.integer "progress_percent", default: 0
    t.bigint "student_id", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_enrollments_on_course_id"
    t.index ["student_id", "course_id"], name: "index_enrollments_on_student_id_and_course_id", unique: true
    t.index ["student_id"], name: "index_enrollments_on_student_id"
  end

  create_table "lesson_completions", force: :cascade do |t|
    t.datetime "completed_at"
    t.datetime "created_at", null: false
    t.bigint "enrollment_id", null: false
    t.bigint "lesson_id", null: false
    t.datetime "updated_at", null: false
    t.index ["enrollment_id", "lesson_id"], name: "index_lesson_completions_on_enrollment_id_and_lesson_id", unique: true
    t.index ["enrollment_id"], name: "index_lesson_completions_on_enrollment_id"
    t.index ["lesson_id"], name: "index_lesson_completions_on_lesson_id"
  end

  create_table "lessons", force: :cascade do |t|
    t.text "context"
    t.bigint "course_id", null: false
    t.datetime "created_at", null: false
    t.integer "position"
    t.string "title"
    t.datetime "updated_at", null: false
    t.string "video_url"
    t.index ["course_id"], name: "index_lessons_on_course_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.integer "role"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "courses", "users", column: "instructor_id"
  add_foreign_key "enrollments", "courses"
  add_foreign_key "enrollments", "users", column: "student_id"
  add_foreign_key "lesson_completions", "enrollments"
  add_foreign_key "lesson_completions", "lessons"
  add_foreign_key "lessons", "courses"
end
