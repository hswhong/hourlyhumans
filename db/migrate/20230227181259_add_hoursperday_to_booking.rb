class AddHoursperdayToBooking < ActiveRecord::Migration[7.0]
  def change
    add_column :bookings, :hours_per_day, :integer
  end
end
