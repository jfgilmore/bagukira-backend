# frozen_string_literal: true

class Unit < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3 }
  validates :user_id, :unit_type, presence: true
  validates :unit_hash, presence: true, on: :update
  enum unit_type: { project: 1, team: 2, organisation: 3 }
  belongs_to :user, counter_cache: true
  has_many :tickets, primary_key: 'unit_hash', dependent: :destroy # restrict_with_exception
  self.primary_key = 'unit_hash'

  def to_param
    unit_hash.parameterize
  end
end
