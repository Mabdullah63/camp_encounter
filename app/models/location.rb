class Location < ApplicationRecord
   include PgSearch::Model

   has_and_belongs_to_many :camps

   pg_search_scope :search, against: [:name],
                  using: {
                    tsearch: { prefix: true, any_word: true}
                  }
end
