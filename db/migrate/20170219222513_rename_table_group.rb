class RenameTableGroup < ActiveRecord::Migration[5.0]
  def change
  	rename_table :group, :groups
  end
end
