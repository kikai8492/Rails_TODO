ActiveRecord::Schema.define(version: 2023_08_17_062638) do

  enable_extension "plpgsql"

  create_table "tasks", force: :cascade do |t|
    t.string "not_started_yet"
    t.string "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "expired_at", default: -> { "CURRENT_DATE" }, null: false
    t.string "status", default: "未着手", null: false
  end

end
