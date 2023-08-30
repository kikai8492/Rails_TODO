FactoryBot.define do
  factory :tag do
    title { "tag1" }
  end

  factory :tag2, class: Tag do
    title { "tag2" }
  end

  factory :tag3, class: Tag do
    title { "tag3" }
  end
end
