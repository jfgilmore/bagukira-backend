class User < ApplicationRecord
<<<<<<< HEAD
  validates :email, format: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, uniqueness: { case_sensitive: false }
  has_many :units, dependent: :destroy
=======
  validates :email, presence: true, format: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, uniqueness: { case_sensitive: false }
  has_many :units
>>>>>>> parent of dee36da... Created User request tests for happy paths, all passing. Created UserController tests for sad paths, all passing.  All private methods covered, created rescue from record not found in ApplicationController.
end
