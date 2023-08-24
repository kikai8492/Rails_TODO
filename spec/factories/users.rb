FactoryBot.define do
  # factory :user do #こっちはサインアップのテストで使用するために作成
  #   name { "test1" }
  #   email { "test1@icloud.com" }
  #   password { "aaaaaa" }
  #   # password_digest { "aaaaaa" }
  #   password_confirmation { "aaaaaa" }
  # end

  factory :login_user ,class: User do #こっちはサインインのテストで使用するために作成
    email { "test1@icloud.com" }
    password { "aaaaaa" }
  end
end
