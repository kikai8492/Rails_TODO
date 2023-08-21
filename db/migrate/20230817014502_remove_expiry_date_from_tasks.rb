class RemoveExpiryDateFromTasks < ActiveRecord::Migration[6.1]
  def change
    remove_column :tasks, :expiry_date, :string
  end
end
