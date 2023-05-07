class Wager < ApplicationRecord
  belongs_to :user
  belongs_to :bet_type
  belongs_to :sport
end
