class AddDeltaToBooks < ActiveRecord::Migration
  def change
    add_column :books, :delta, :boolean, :default => true,
    :null => false
  end
end
