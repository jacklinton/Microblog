class User < ActiveRecord::Base
	has_many :posts
	has_many :comments, through: :posts
	belongs_to :group
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