FactoryBot.define do
  factory :user do #こっちはサインアップのテストで使用するために作成
    name { "test1" }
    email { "test1@icloud.com" }
    password { "aaaaaa" }
    admin {"false"}
  end

  factory :user2 ,class: User do
    name { "test2" }
    email { "test2@icloud.com" }
    password { "aaaaaa" }
    admin {"false"}
  end

  factory :admin_user ,class: User do
    name { "kikai"}
    email { "yysskikai04@icloud.com" }
    password { "aaaaaa" }
    admin {"true"}
  end


end
