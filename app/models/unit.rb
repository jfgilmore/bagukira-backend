class Unit < ApplicationRecord
  validates :user, presence: true
  validates :name, presence: true, length: { minimum: 3 }
  # validates :unit_type, presence: true
  enum unit_type: { project: 0, team: 1, organisation: 2 }
  belongs_to :user
end
