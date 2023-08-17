class Task < ApplicationRecord
  validates :not_started_yet, presence: true
  validates :content, presence: true

  # self.data = [
  #   {id: 1,status: "未着手"},
  #   {id: 2,status: "着手中"},
  #   {id: 3,status: "完了"}
  # ]
end
