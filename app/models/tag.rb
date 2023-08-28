class Tag < ApplicationRecord
  has_many :task  
  # scope :tags_title, -> (title) { #タグ名で検索する時のスコープ
  #   where('tags.title LIKE ?', "%#{title}%")
  # }

end
