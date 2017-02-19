class User < ActiveRecord::Base
	has_many :posts
	has_many :comments, through: :posts
	belongs_to :group

	def self.group_id
		Group.where(name: User.group_name).first
		
	end
end

class Post < ActiveRecord::Base
	belongs_to :user
	has_one :group, through: :user
	has_many :comments
end
					
class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :post
end

class Group < ActiveRecord::Base
	has_many :users
	has_many :posts, through: :users
end