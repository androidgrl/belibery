class Donation < ActiveRecord::Base
  validates :amount, numericality: { only_integer: true }, exclusion: { in: [1] }
  validates :status, inclusion: { in: %w(processed pending cancelled) }
  belongs_to :fan
end
