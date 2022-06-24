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

ActiveRecord::Schema.define(version: 2022_06_23_212856) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "git_hub_event_hourly_queues", force: :cascade do |t|
    t.string "type"
    t.bigint "count"
    t.datetime "date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["type"], name: "index_git_hub_event_hourly_queues_on_type"
  end

  create_table "git_hub_event_hourly_rollups", force: :cascade do |t|
    t.string "type"
    t.bigint "count"
    t.datetime "date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["type"], name: "index_git_hub_event_hourly_rollups_on_type"
  end

  create_table "git_hub_events", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.string "type"
    t.boolean "public"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id"], name: "index_git_hub_events_on_event_id"
    t.index ["type"], name: "index_git_hub_events_on_type"
  end


  create_view "git_hub_event_hourlies", sql_definition: <<-SQL
      SELECT git_hub_event_hourly.type,
      git_hub_event_hourly.date,
      sum(git_hub_event_hourly.count) AS sum
     FROM ( SELECT git_hub_event_hourly_rollups.type,
              git_hub_event_hourly_rollups.date,
              git_hub_event_hourly_rollups.count
             FROM git_hub_event_hourly_rollups
          UNION ALL
           SELECT git_hub_event_hourly_queues.type,
              git_hub_event_hourly_queues.date,
              git_hub_event_hourly_queues.count
             FROM git_hub_event_hourly_queues) git_hub_event_hourly
    GROUP BY git_hub_event_hourly.type, git_hub_event_hourly.date;
  SQL
end
