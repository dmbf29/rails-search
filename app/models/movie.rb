class Movie < ApplicationRecord
  belongs_to :director
  # this gives us the pg_search methods
  include PgSearch::Model

  pg_search_scope :search,
                  against: %i[title synopsis],
                  associated_against: {
                    director: %i[first_name last_name]
                  },
                  using: {
                    tsearch: { prefix: true } # this allows for partial matching
                  }
end
