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
    self.where(trip_a_id: a.id, trip_b_id: b.id).first_or_initialize
  end

  def reversed
    TripConnection.for_trips(trip_b, trip_a)
  end

  def mutual?
    accepted? && reversed.accepted?
  end

  def messages
    Message.where("(trip_a_id = :aid AND trip_b_id = :bid) OR (trip_a_id = :bid AND trip_b_id = :aid)",
      aid: trip_a_id, bid: trip_b_id)
      .order(created_at: :asc)
  end
end
