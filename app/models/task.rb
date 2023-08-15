class Task < ApplicationRecord
  validates :not_started_yet, presence: true
  validates :content, presence: true
end
