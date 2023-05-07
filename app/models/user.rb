class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  has_many :wagers
  has_many :bet_types, through: :wagers
  has_many :sports, through: :wagers
end
