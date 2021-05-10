# frozen_string_literal: true

class User < ApplicationRecord
  validates :email, presence: true, format: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, uniqueness: { case_sensitive: false }
  has_secure_password
  has_many :units, dependent: :nullify
end
