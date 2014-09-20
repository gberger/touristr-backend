class TripConnection < ActiveRecord::Base
  enum status: [:unknown, :rejected, :accepted]
  belongs_to :trip_a, class_name: Trip
  belongs_to :trip_b, class_name: Trip

  validates_presence_of :trip_a, :trip_b, :status
  validate :different_trips

  def different_trips
    trip_a_id != trip_b_id
  end

  def self.for_trips(a, b)
    self.where(trip_a: a.id, trip_b: b.id).first_or_initialize
  end

  def reversed
    TripConnection.find(trip_a: trip_b, trip_b: trip_a)
  end

  def mutual?
    accepted? && reversed.accepted?
  end
end
