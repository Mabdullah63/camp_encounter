class Camp < ApplicationRecord

  has_and_belongs_to_many :locations

  validate :check_end_date?

  def check_end_date?
    if end_date < start_date
      errors.add :end_date, "end date must be greater than start date"
    end
  end
end
