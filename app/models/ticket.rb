class Ticket < ApplicationRecord
  validates :subject, :status, :unit_id, :opened_by, presence: true
  validates :closed_by, presence: true, if: :status_closed?, on: :update
  enum status: { open: 1, in_progress: 2, closed: 3 }
  enum severity: { low: 1, medium: 2, major: 3, critical: 4 }
  belongs_to :unit, primary_key: 'unit_hash', counter_cache: true

  def to_param
    ticket_num.parameterize
  end

  def status_closed?
    status == 'closed'
  end
end
