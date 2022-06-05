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

ActiveRecord::Schema.define(version: 2022_06_05_122514) do

  create_table "ex_score_differences", charset: "utf8mb4", force: :cascade do |t|
    t.integer "ex_score_id", null: false
    t.integer "upload_status_id", null: false
    t.integer "before_ex_score", null: false
    t.integer "after_ex_score", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "ex_scores", charset: "utf8mb4", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "song_id", null: false
    t.integer "ex_score", default: 0, null: false
    t.integer "play_count", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "max", default: false, null: false
  end

  create_table "songs", charset: "utf8mb4", force: :cascade do |t|
    t.string "name", default: "-", null: false
    t.integer "level", default: 0, null: false
    t.integer "difficult", default: 0, null: false
    t.integer "max_ex_score", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "upload_statuses", charset: "utf8mb4", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "upload_score_count", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", charset: "utf8mb4", force: :cascade do |t|
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "username", default: "", null: false
    t.string "player_id"
    t.string "player_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "deleted", default: false, null: false
    t.integer "deleted_at"
    t.boolean "is_admin", default: false
    t.integer "score_opened", default: 0, null: false
    t.integer "ranking_opened", default: 0, null: false
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

end
