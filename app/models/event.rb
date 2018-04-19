class Event < ActiveRecord::Base
  belongs_to :user
  has_many :attendees, dependent: :destroy
  has_many :users_attending, through: :attendees, source: :event

  validates :name, :city, presence: true, length:{minimum: 2}
  validates :date, :user_id, presence: true
  validates :state, presence: true, length: { is: 2}  
  validates :user_id, :presence => true, on: :create 
  validate :event_date_cannot_be_in_the_past



def event_date_cannot_be_in_the_past
	errors.add(:date, "can't be in the past") if
    !date.blank? and date < Date.today
end	

end
