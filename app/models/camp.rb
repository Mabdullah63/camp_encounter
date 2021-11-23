class Camp < ApplicationRecord
  include PgSearch::Model

  has_and_belongs_to_many :locations
  has_many :user_applications
  has_many :users, through: :user_applications

  validate :check_end_date?

  pg_search_scope :search, against: [:name, :start_date, :end_date, :created_at, :id, :camp_type],
                  using: {
                    tsearch: { prefix: true, any_word: true}
                  }

  def check_end_date?
    if end_date < start_date
      errors.add :end_date, "end date must be greater than start date"
    end
  end
end
