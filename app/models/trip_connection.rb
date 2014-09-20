class TripConnection < ActiveRecord::Base
  enum status: [:unknown, :rejected, :accepted]
  belongs_to :trip_a, class_name: Trip
  belongs_to :trip_b, class_name: Trip

  validates_presence_of :trip_a, :trip_b, :status

  def reversed
    TripConnection.find(trip_a: trip_b, trip_b: trip_a)
  end
end
