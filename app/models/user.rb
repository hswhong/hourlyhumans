class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :bookings_as_bookee, class_name: "Booking", foreign_key: :user_bookee_id
  has_many :bookings_as_booker, class_name: "Booker", foreign_key: :user_booker_id

  has_one_attached :photo

  include PgSearch::Model
  pg_search_scope :search_by_first_name_and_task,
                  against: %i[first_name task],
                  using: {
                    tsearch: { prefix: true } # <-- now `superman batm` will return something!
                  }
end
