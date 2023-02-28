class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :bookings_as_bookee, class_name: "Booking", foreign_key: :user_bookee_id
  has_many :bookings_as_booker, class_name: "Booker", foreign_key: :user_booker_id

  has_one_attached :photo
end
