class AddAdminToUser < ActiveRecord::Migration
  def change
    add_column :users, :admin, :bit, :default=>false
  end
end
