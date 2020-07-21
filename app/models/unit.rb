class Unit < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3 }
  validates :user_id, presence: true
  validates :unit_type, presence: true
  enum unit_type: { project: 0, team: 1, organisation: 2 }
  belongs_to :user
end
