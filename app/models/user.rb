class User < ApplicationRecord
  has_secure_password
  has_many :commitments
  validates :email, presence: true, uniqueness: true
end
