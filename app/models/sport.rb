class Sport < ApplicationRecord
  has_many :wagers
  has_many :users, through: :wagers
  has_many :bet_types, through: :wagers
end
