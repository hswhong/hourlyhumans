class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.date :start_date
      t.date :end_date
      t.float :total_price
      t.references :user_bookee, foreign_key: { to_table: :users }
      t.references :user_booker, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
