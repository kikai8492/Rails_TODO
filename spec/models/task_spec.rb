require 'rails_helper'
RSpec.describe 'タスクモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.new(not_started_yet: '')
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        # ここに内容を記載する
        task = Task.new(not_started_yet: '失敗テスト', content: '')
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        # ここに内容を記載する
        task = Task.new(not_started_yet: '成功テスト', content: '成功テスト')
        expect(task).to be_valid #task.valid? が true ならテストは期待通りに動いてることになります。
      end
    end
  end

  describe '検索機能' do
    let!(:task) { FactoryBot.create(:task, not_started_yet: 'task', expired_at: '002023-08-18', status:'未着手') }
    let!(:second_task) { FactoryBot.create(:second_task, not_started_yet: "sample", expired_at: '002023-08-19', status: '完了') }
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        expect(Task.not_started_yet('task')).to include(task)
        expect(Task.not_started_yet('task')).not_to include(second_task)
        expect(Task.not_started_yet('task').count).to eq 1
      end
      it "scopeメソッドでステータス検索をした場合" do
        expect(Task.status('未着手')).to include(task)
        expect(Task.status('未着手')).not_to include(second_task)
        expect(Task.status('未着手').count).to eq 1
      end
      it "scopeメソッドでタイトルのあいまい検索とステータス検索をした場合" do
        expect(Task.not_started_yet('task').status('未着手')).to include(task)
        expect(Task.not_started_yet('task').status('未着手')).not_to include(second_task)
        expect(Task.not_started_yet('task').status('未着手').count).to eq 1
      end
    end
  end
end
