class Unit < ApplicationRecord
<<<<<<< HEAD
  validates :name, presence: true, length: { minimum: 3 }
  validates :user_id, presence: true
=======
  belongs_to :user
  validates :user, presence: true
  validates :name, presence: true, length: { minimum: 3 }
>>>>>>> parent of dee36da... Created User request tests for happy paths, all passing. Created UserController tests for sad paths, all passing.  All private methods covered, created rescue from record not found in ApplicationController.
  validates :unit_type, presence: true
  enum unit_type: { project: 0, team: 1, organisation: 2 }
end
