class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  validates :user_id, :event_id, presence:true
  validates :content, presence:true
end
