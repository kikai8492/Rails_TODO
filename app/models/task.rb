class Task < ApplicationRecord
  validates :not_started_yet, presence: true
  validates :content, presence: true

  # def self.search(not_started_yet)
  #   Task.where('not_started_yet LIKE(?)', "%#{not_started_yet}%")
  # end
end
