class Ticket < ApplicationRecord
  validates :subject, :status, :unit_id, :opened_by, presence: true
  validates :closed_by, presence: true, if: :status_closed?, on: :update
  enum status: { OPEN: 1, "IN PROGRESS": 2, CLOSED: 3 }
  enum severity: { LOW: 1, MEDIUM: 2, HIGH: 3, CRITICAL: 4 }
  belongs_to :unit, primary_key: 'unit_hash', counter_cache: true

  def to_param
    ticket_num.parameterize
  end

  def status_closed?
    status == 'CLOSED'
  end
end
