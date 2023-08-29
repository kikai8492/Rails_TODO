class Tag < ApplicationRecord
  has_many :task  
  # scope :title, -> (title) { #タグ名で検索する時のスコープ
  #   where('title LIKE ?', "%#{title}%")
  # }

end
