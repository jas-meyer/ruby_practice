class Follow < ActiveRecord::Base
	belongs_to :follower, required: true, class_name: 'User'
	belongs_to :followee, required:true, class_name: 'User'
end
