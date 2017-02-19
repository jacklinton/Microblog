class CreateUsersTable < ActiveRecord::Migration[5.0]
  create_table :users do |t|
  		t.string :username
  		t.string :password
  		t.binary :avatar
  		t.string :group

  		t.timestamps
  end
end
