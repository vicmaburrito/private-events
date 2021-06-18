class Event < ApplicationRecord
  # belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  belongs_to :user
  has_many :enrollments
  has_many :attendees, through: :enrollments, source: :user
  # scope :past, -> { where('date < ?', Date.today) }
  # scope :upcoming, -> { where('date >= ?', Date.today) }
end
