FactoryBot.define do
  factory :task do
    # 下記の内容は実際に作成するカラム名に合わせて変更してください
    not_started_yet { 'test_title' }
    content { 'test_content' }
  end
end
