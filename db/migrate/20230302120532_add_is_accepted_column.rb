class AddIsAcceptedColumn < ActiveRecord::Migration[7.0]
  def change
    add_column :bookings, :is_accepted, :boolean
  end
end
