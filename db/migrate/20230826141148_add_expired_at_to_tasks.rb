class AddExpiredAtToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :expired_at, :date, null: false, default: -> { 'CURRENT_DATE' }
  end
end
