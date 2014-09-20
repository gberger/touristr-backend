class Trip < ActiveRecord::Base
  belongs_to :user

  def find_candidates
    Trip.where("city = :city AND (start_date <= :end_date OR end_date <= :start_date)",
               city: city, start_date: start_date, end_date: end_date)
  end
end
