class AddCategoryToBooks < ActiveRecord::Migration
  def change
    add_column :books, :category, :string
  end
end
