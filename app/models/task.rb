class Task < ApplicationRecord
  validates :not_started_yet, presence: true
  validates :content, presence: true
  validates :expiry_date, presence: true
end
