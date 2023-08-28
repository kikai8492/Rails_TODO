class AddTaskRefToTags < ActiveRecord::Migration[6.1]
  def change
    add_reference :tags, :task, null: false, foreign_key: true
  end
end
