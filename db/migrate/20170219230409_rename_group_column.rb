class RenameGroupColumn < ActiveRecord::Migration[5.0]
  def change
  	remove_column :users, :group
  	add_column :users, :group_name, :string
  end
end
