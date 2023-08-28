class AddAdminToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :admin, :boolean, default: false, null: false #default: falseはデフォルト値をfalseにするという意味。null: falseはnullを許可しないという意味。
  end
end
