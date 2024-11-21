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

ActiveRecord::Schema[7.1].define(version: 2024_09_18_035644) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string "trackable_type"
    t.bigint "trackable_id"
    t.string "owner_type"
    t.bigint "owner_id"
    t.string "key"
    t.text "parameters"
    t.string "recipient_type"
    t.bigint "recipient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type"
    t.index ["owner_type", "owner_id"], name: "index_activities_on_owner"
    t.index ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type"
    t.index ["recipient_type", "recipient_id"], name: "index_activities_on_recipient"
    t.index ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type"
    t.index ["trackable_type", "trackable_id"], name: "index_activities_on_trackable"
  end

  create_table "answers", force: :cascade do |t|
    t.bigint "standup_id", null: false
    t.bigint "question_id", null: false
    t.text "answer"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
    t.index ["standup_id"], name: "index_answers_on_standup_id"
  end

  create_table "holidays", force: :cascade do |t|
    t.bigint "tenant_id", null: false
    t.text "name", null: false
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tenant_id"], name: "index_holidays_on_tenant_id"
  end

  create_table "noticed_events", force: :cascade do |t|
    t.string "type"
    t.string "record_type"
    t.bigint "record_id"
    t.jsonb "params"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "notifications_count"
    t.index ["record_type", "record_id"], name: "index_noticed_events_on_record"
  end

  create_table "noticed_notifications", force: :cascade do |t|
    t.string "type"
    t.bigint "event_id", null: false
    t.string "recipient_type", null: false
    t.bigint "recipient_id", null: false
    t.datetime "read_at", precision: nil
    t.datetime "seen_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_noticed_notifications_on_event_id"
    t.index ["recipient_type", "recipient_id"], name: "index_noticed_notifications_on_recipient"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.integer "age"
    t.string "email"
    t.string "university"
    t.string "level_of_education"
    t.float "cgpa"
    t.string "job_title"
    t.string "company"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.bigint "template_id", null: false
    t.text "question", null: false
    t.string "question_type", null: false
    t.text "options"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["template_id"], name: "index_questions_on_template_id"
  end

  create_table "sprints", force: :cascade do |t|
    t.string "name"
    t.date "start_date"
    t.date "end_date"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sprints_on_user_id"
  end

  create_table "standups", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "template_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["template_id"], name: "index_standups_on_template_id"
    t.index ["user_id"], name: "index_standups_on_user_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.text "name"
    t.text "desciption"
    t.string "status"
    t.bigint "sprint_id", null: false
    t.bigint "created_by_id", null: false
    t.bigint "assigned_to_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assigned_to_id"], name: "index_tasks_on_assigned_to_id"
    t.index ["created_by_id"], name: "index_tasks_on_created_by_id"
    t.index ["sprint_id"], name: "index_tasks_on_sprint_id"
  end

  create_table "tasks_users", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "task_id", null: false
    t.index ["task_id", "user_id"], name: "index_tasks_users_on_task_id_and_user_id"
    t.index ["user_id", "task_id"], name: "index_tasks_users_on_user_id_and_task_id"
  end

  create_table "team_employees", force: :cascade do |t|
    t.bigint "team_id", null: false
    t.bigint "tenant_id", null: false
    t.bigint "user_id", null: false
    t.string "role", default: "employee", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_team_employees_on_team_id"
    t.index ["tenant_id"], name: "index_team_employees_on_tenant_id"
    t.index ["user_id"], name: "index_team_employees_on_user_id"
  end

  create_table "team_holidays", force: :cascade do |t|
    t.bigint "tenant_id", null: false
    t.bigint "team_id", null: false
    t.text "name", null: false
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_team_holidays_on_team_id"
    t.index ["tenant_id"], name: "index_team_holidays_on_tenant_id"
  end

  create_table "team_settings", force: :cascade do |t|
    t.bigint "tenant_id", null: false
    t.bigint "team_id", null: false
    t.text "date_format", default: "DD-MM-YYYY", null: false
    t.text "approver_called_as", default: "Approver", null: false
    t.text "employee_called_as", default: "Employee", null: false
    t.integer "working_hours", default: 5
    t.json "work_week", default: ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday"]
    t.text "teams_called_as", default: "Team", null: false
    t.boolean "all_unlimited_days", default: false, null: false
    t.boolean "all_auto_approve", default: false, null: false
    t.integer "fy_start_month", default: 1
    t.integer "fy_end_month", default: 12
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_team_settings_on_team_id"
    t.index ["tenant_id"], name: "index_team_settings_on_tenant_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "tenant_id", null: false
    t.bigint "created_by", null: false
    t.string "channel_id"
    t.string "channel_name"
    t.boolean "is_bot_added"
    t.json "auto_approved_leave_type"
    t.text "channel_service_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by"], name: "index_teams_on_created_by"
    t.index ["tenant_id"], name: "index_teams_on_tenant_id"
  end

  create_table "templates", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_templates_on_user_id"
  end

  create_table "tenant_employees", force: :cascade do |t|
    t.bigint "tenant_id", null: false
    t.bigint "user_id", null: false
    t.string "role", default: "employee", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tenant_id"], name: "index_tenant_employees_on_tenant_id"
    t.index ["user_id"], name: "index_tenant_employees_on_user_id"
  end

  create_table "tenant_settings", force: :cascade do |t|
    t.bigint "tenant_id", null: false
    t.text "date_format", default: "DD-MM-YYYY", null: false
    t.text "approver_called_as", default: "Approver", null: false
    t.text "employee_called_as", default: "Employee", null: false
    t.integer "working_hours", default: 5
    t.json "work_week", default: ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday"]
    t.text "teams_called_as", default: "Team", null: false
    t.boolean "all_unlimited_days", default: false, null: false
    t.boolean "all_auto_approve", default: false, null: false
    t.integer "fy_start_month", default: 1
    t.integer "fy_end_month", default: 12
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tenant_id"], name: "index_tenant_settings_on_tenant_id"
  end

  create_table "tenants", force: :cascade do |t|
    t.string "name"
    t.bigint "created_by", null: false
    t.uuid "workspace_id"
    t.string "sign_in_by", default: "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by"], name: "index_tenants_on_created_by"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "time_zone", default: "Kolkata"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "answers", "questions"
  add_foreign_key "answers", "standups"
  add_foreign_key "holidays", "tenants"
  add_foreign_key "profiles", "users"
  add_foreign_key "questions", "templates"
  add_foreign_key "sprints", "users"
  add_foreign_key "standups", "templates"
  add_foreign_key "standups", "users"
  add_foreign_key "tasks", "sprints"
  add_foreign_key "tasks", "users", column: "assigned_to_id"
  add_foreign_key "tasks", "users", column: "created_by_id"
  add_foreign_key "team_employees", "teams"
  add_foreign_key "team_employees", "tenants"
  add_foreign_key "team_employees", "users"
  add_foreign_key "team_holidays", "teams"
  add_foreign_key "team_holidays", "tenants"
  add_foreign_key "team_settings", "teams"
  add_foreign_key "team_settings", "tenants"
  add_foreign_key "teams", "tenants"
  add_foreign_key "teams", "users", column: "created_by"
  add_foreign_key "templates", "users"
  add_foreign_key "tenant_employees", "tenants"
  add_foreign_key "tenant_employees", "users"
  add_foreign_key "tenant_settings", "tenants"
  add_foreign_key "tenants", "users", column: "created_by"
end
