class BetType < ApplicationRecord
  has_many :wagers
  has_many :users, through: :wagers
  has_many :sports, through: :wagers
end
