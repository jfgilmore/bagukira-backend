class User < ApplicationRecord
  validates :email, format: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, uniqueness: { case_sensitive: false }
  has_secure_password
  has_many :units, dependent: :nullify
end
