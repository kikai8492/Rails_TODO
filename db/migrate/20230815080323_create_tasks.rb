class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :not_started_yet
      t.string :content
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
