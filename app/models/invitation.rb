class Invitation < ApplicationRecord
  belongs_to  :attendee,        class_name: "User"
  belongs_to  :attended_event,  class_name: "Event"
  self.per_page = 5
end
