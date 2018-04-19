class User < ActiveRecord::Base
  has_secure_password
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  has_many :events
  has_many :attendees, dependent: :destroy
  has_many :events_attending, through: :attendees, source: :event


  has_many :follow_following, foreign_key: :follower_id, class_name: 'Follow'
  has_many :following, through: :follow_following, source: :followee

  has_many :follow_followers, foreign_key: :followee_id, class_name: 'Follow'
  has_many :followers, through: :follow_followers, source: :follower 

  
  validates :first_name, :last_name, :city, presence: true, length:{minimum: 2}
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
  validates :state, presence: true, length: { is: 2}  
  validates :password, :password_confirmation, length:{minimum: 8}, :presence => true, on: :create 
end
