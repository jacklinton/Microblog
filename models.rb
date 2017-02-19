class User < ActiveRecord::Base
	has_many :posts
	has_many :comments, through: :posts
	belongs_to :group
end

class Post < ActiveRecord::Base
	belongs_to :user
	belongs_to :group, through: :post
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