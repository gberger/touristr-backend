class Trip < ActiveRecord::Base
  belongs_to :user

  has_and_belongs_to_many :trips,
                          join_table: "trip_connections",
                          foreign_key: "trip_a_id",
                          association_foreign_key: "trip_b_id"
  validate :start_lt_end

  def start_lt_end
    start_date <= end_date
  end

  def find_candidates
    Trip.includes(:user)
      .where("id NOT IN (:d) AND user_id != :user_id AND city = :city AND (start_date <= :end_date OR end_date <= :start_date)",
               d: decided_candidates.select(:trip_b_id), user_id: user_id, city: city, start_date: start_date, end_date: end_date)
  end

  def decided_candidates
    TripConnection.where("trip_a_id = :id AND status != 0", id: id)
  end

  def matches
    Trip.includes(:user).find_by_sql("
      select t.*
      from trips t
      inner join trip_connections c1 on c1.trip_a_id = #{id} and c1.trip_b_id = t.id and c1.status = 2
      inner join trip_connections c2 on c2.trip_a_id = t.id and c2.trip_b_id = #{id} and c2.status = 2")
  end

  def matches?(other)
    TripConnection.for_trips(self, other).mutual?
  end
end
