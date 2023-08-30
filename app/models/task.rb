class Task < ApplicationRecord
  belongs_to :user
  has_many :taggings, dependent: :delete_all
  has_many :tags, through: :taggings
  # accepts_nested_attributes_for :tag, reject_if: :all_blank, allow_destroy: true
  validates :not_started_yet, presence: true
  validates :content, presence: true

  scope :sort_expired, -> { order(expired_at: :asc) } #終了期限で並び替える時のスコープ

  # scope :not_started_yet_and_status, -> (not_started_yet, status) { #タイトルとステータスで検索する時のスコープ
  #   where('not_started_yet LIKE ? AND status LIKE ?', "%#{not_started_yet}%", "%#{status}%")
  # }

  # scope :not_started_yet_and_status_and_title, -> (not_started_yet, status, title) { #タイトルとステータスとタグで検索する時のスコープ
  #   where('not_started_yet LIKE ? AND status LIKE ? AND title LIKE?', "%#{not_started_yet}%", "%#{status}%", "%#{title}%")
  # }

  scope :not_started_yet, -> (not_started_yet) { #タイトルで検索する時のスコープ
    where('not_started_yet LIKE ?', "%#{not_started_yet}%")
  }

  scope :status, -> (status) { #ステータスで検索する時のスコープ
    where('status LIKE ?', "%#{status}%")
  }

  # scope :tags_title, -> (title) { #タグ名で検索する時のスコープ
  #   where('tags.title LIKE ?', "%#{title}%")
  # }

  # scope :title, -> (title) { #タグ名で検索する時のスコープ
  #   where('title LIKE ?', "%#{title}%")
  # }

  # scope :title, -> (title) { #タグ名で検索する時のスコープ
  #   where(title:"#{title}")
  # }


  enum priority: {低: 0, 中: 1, 高: 2} #優先順位のenum
  scope :sort_priority, -> { #優先順位で並び替える
    order(priority: :desc)
  }

  paginates_per 5 #1ページあたり5項目表示
end
