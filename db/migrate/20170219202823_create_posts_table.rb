class CreatePostsTable < ActiveRecord::Migration[5.0]
  
  def change
  	create_table :posts do |t|
  		t.string :title
  		t.text :meme
  		t.integer :user_id
  		t.integer :group_id

  		t.timestamps
	end
  end
end
