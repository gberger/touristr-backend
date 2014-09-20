class Trip < ActiveRecord::Base
  belongs_to :user

  def find_candidates
    Trip.includes(:user).where("user_id != :user_id AND city = :city AND (start_date <= :end_date OR end_date <= :start_date)",
               user_id: user_id, city: city, start_date: start_date, end_date: end_date)
  end
end
