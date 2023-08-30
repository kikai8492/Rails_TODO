FactoryBot.define do
  factory :task do
    # 下記の内容は実際に作成するカラム名に合わせて変更してください
    not_started_yet { 'test_title1' }
    content { 'test_content1' }
    expired_at { '002021-08-18' }
    priority { '高' }
    status { '着手中' }

    # association :tag
    # title { 'tag1' }
  end

  factory :second_task, class: Task do #models/task.rbの検索機能のテストで使用するために作成
    not_started_yet { 'test_title2' }
    content { 'test_content2' }
    expired_at { '002021-08-19' }
    priority { '中' }
    status { '未着手' }

    # association :tag
    # title { 'tag2' }
  end
end
