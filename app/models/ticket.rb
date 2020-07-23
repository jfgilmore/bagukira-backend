class Ticket < ApplicationRecord
  validates :subject, :status, :unit_hash, :opened_by, presence: true
  enum status: { open: 1, in_progress: 2, closed: 3 }
  belongs_to :unit, primary_key: 'unit_hash', counter_cache: true

  def location_id_or_other
    errors.add(:closed_by, 'is required if status is closed') if status == :closed && closed_by.blank?
  end
end
