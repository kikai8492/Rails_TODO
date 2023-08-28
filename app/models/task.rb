class Task < ApplicationRecord
  belongs_to :user
  validates :not_started_yet, presence: true
  validates :content, presence: true

  scope :sort_expired, -> { order(expired_at: :asc) } #終了期限で並び替える時のスコープ

  scope :not_started_yet_and_status, -> (not_started_yet, status) { #タイトルとステータスで検索する時のスコープ
    where('not_started_yet LIKE ? AND status LIKE ?', "%#{not_started_yet}%", "%#{status}%")
  }

  scope :not_started_yet, -> (not_started_yet) { #タイトルで検索する時のスコープ
    where('not_started_yet LIKE ?', "%#{not_started_yet}%")
  }

  scope :status, -> (status) { #ステータスで検索する時のスコープ
    where('status LIKE ?', "%#{status}%")
  }

  enum priority: {低: 0, 中: 1, 高: 2} #優先順位のenum
  scope :sort_priority, -> { #優先順位で並び替える
    order(priority: :desc)
  }

  paginates_per 5 #1ページあたり5項目表示
end
