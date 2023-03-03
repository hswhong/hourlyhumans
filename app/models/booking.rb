class Booking < ApplicationRecord
  belongs_to :user_bookee, class_name: "User"
  belongs_to :user_booker, class_name: "User"

  has_many :reviews
end
