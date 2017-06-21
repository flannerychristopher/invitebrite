class Event < ApplicationRecord
  belongs_to  :creator,     class_name:   "User"
  has_many    :attendees,   through:      :invitations
  has_many    :invitations, foreign_key:  "attended_even_id"

  validates :title, presence: true, length: { maximum: 75 }
  validates :date, presence: true
  validates :location, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 500 }
end
