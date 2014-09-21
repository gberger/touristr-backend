class Message < ActiveRecord::Base
  validates :msg, length: { in: 1..512 }
  validates_presence_of :msg, :trip_a_id, :trip_b_id
  validate :different_trips

  def different_trips
    trip_a_id != trip_b_id
  end

  before_validation do
    self.msg = self.msg[0...512] if attribute_present?("msg") && self.msg.length > 512
  end

end
