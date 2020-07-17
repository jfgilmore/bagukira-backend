class User < ApplicationRecord
  validates :email, presence: true, format: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, uniqueness: { case_sensitive: false }
  has_many :units
end
