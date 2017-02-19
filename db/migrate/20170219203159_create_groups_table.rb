class CreateGroupsTable < ActiveRecord::Migration[5.0]
  def change
  	create_table :group do |t|
  		t.string :name
  		t.binary :avatar
  		t.integer :administrator_id
  		
  		t.timestamps
	end
  end

end
