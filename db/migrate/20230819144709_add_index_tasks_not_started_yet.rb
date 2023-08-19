class AddIndexTasksNotStartedYet < ActiveRecord::Migration[6.1]
  def change
    add_index :tasks, :not_started_yet
  end
end
