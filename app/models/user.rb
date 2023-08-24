class User < ApplicationRecord
  before_destroy :must_not_destroy_last_one_admin #最後の管理者が削除されないようにする。つまり管理者が最低一人は必要
  has_many :tasks, dependent: :delete_all
  has_secure_password
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, presence: true, length: { minimum: 6 }

  private

  def must_not_destroy_last_one_admin
    if User.where(admin: true).count <= 1 && self.admin  #self.adminは削除しようとしているユーザーが管理者かどうかを判定する
      throw(:abort) #throw(:abort)は処理をしないという意味
    end
  end
end
