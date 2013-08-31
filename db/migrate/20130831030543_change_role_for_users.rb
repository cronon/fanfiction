class ChangeRoleForUsers < ActiveRecord::Migration
  def change
  	remove_column :users, :role, :string
  	add_column :users, :role, :string, :default=>'user'
  end
end
