class DeleteTaskIdToTags < ActiveRecord::Migration[6.1]
  def change
    remove_column :tags, :task_id
  end
end
