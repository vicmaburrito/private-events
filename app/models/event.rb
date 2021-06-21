class Event < ApplicationRecord
  belongs_to :user
  scope :past, -> { where('date < ?', DateTime.now) }
  scope :future, -> { where('date >= ?', DateTime.now) }
end
