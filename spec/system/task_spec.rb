require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  
  describe '新規作成機能' do 
    let!(:user) { FactoryBot.create(:user) }
    before do
      visit new_user_path
      fill_in 'user_name', with: user.name
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      fill_in 'user_password_confirmation', with: user.password
      click_on 'アカウントを作成する'
      visit new_session_path
      fill_in 'session_email', with: user.email
      fill_in 'session_password', with: user.password
      click_on 'ログインする'
    end
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        # 1. new_task_pathに遷移する（新規作成ページに遷移する）
        # ここにnew_task_pathにvisitする処理を書く
        visit new_task_path
        # 2. 新規登録内容を入力する
        #「タスク名」というラベル名の入力欄と、「タスク詳細」というラベル名の入力欄にタスクのタイトルと内容をそれぞれ入力する
        # ここに「タスク名」というラベル名の入力欄に内容をfill_in（入力）する処理を書く
        fill_in 'text', with: 'task'
        fill_in 'content', with: 'task'
        fill_in 'expired_at', with: '002023-08-18'
        select '着手中', from: 'task_status'
        select '高', from: 'task_priority'
        #textはタスク名のtext_fieldのid
        # ここに「タスク詳細」というラベル名の入力欄に内容をfill_in（入力）する処理を書く
        # 3. 「登録する」というvalue（表記文字）のあるボタンをクリックする
        # ここに「登録する」というvalue（表記文字）のあるボタンをclick_onする（クリックする）する処理を書く
        click_on ('タスクを追加する')
        # 4. clickで登録されたはずの情報が、タスク詳細ページに表示されているかを確認する
        # （タスクが登録されたらタスク詳細画面に遷移されるという前提）
        # ここにタスク詳細ページに、テストコードで作成したデータがタスク詳細画面にhave_contentされているか（含まれているか）を確認（期待）するコードを書く
        expect(page).to have_content 'task'
        expect(page).to have_content 'task'
        expect(page).to have_content '2023-08-18'
        expect(page).to have_content '着手中'
        expect(page).to have_content '高'
      end
    end
  end

  describe '一覧表示機能' do
    let!(:user) { FactoryBot.create(:user) }
    before do
      visit new_user_path
      fill_in 'user_name', with: user.name
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      fill_in 'user_password_confirmation', with: user.password
      click_on 'アカウントを作成する'
      visit new_session_path
      fill_in 'session_email', with: user.email
      fill_in 'session_password', with: user.password
      click_on 'ログインする'
    end
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        # テストで使用するためのタスクを作成
        # FactoryBot.create(:task, not_started_yet: 'task1', content: 'test1',expired_at: '002023-08-18')
        # FactoryBot.create(:task, not_started_yet: 'task2', content: 'test2',expired_at: '002023-08-19')
        visit new_task_path
        fill_in 'text', with: 'task'
        fill_in 'content', with: 'task'
        fill_in 'expired_at', with: '002023-08-18'
        select '着手中', from: 'task_status'
        select '高', from: 'task_priority'
        click_on 'タスクを追加する'
        # タスク一覧ページに遷移
        visit tasks_path
        # visitした（遷移した）page（タスク一覧ページ）に「task」という文字列が
        # have_contentされているか（含まれているか）ということをexpectする（確認・期待する）
        expect(page).to have_content 'task'
        # expectの結果が true ならテスト成功、false なら失敗として結果が出力される
      end
    end
  end

  describe '検索機能' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:task) { FactoryBot.create(:task, user: user) }
    let!(:second_task) { FactoryBot.create(:second_task, user: user) }
    let!(:tag) { FactoryBot.create(:tag) }
    let!(:tag2) { FactoryBot.create(:tag2) }
    let!(:tag3) { FactoryBot.create(:tag3) }
    before do
      visit new_user_path
      fill_in 'user_name', with: user.name
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      fill_in 'user_password_confirmation', with: user.password
      click_on 'アカウントを作成する'
      visit new_session_path
      fill_in 'session_email', with: user.email
      fill_in 'session_password', with: user.password
      click_on 'ログインする'
    end
    context 'タイトルであいまい検索をした場合' do
      it '検索キーワードを含むタスクで絞り込める' do
        visit tasks_path
        fill_in 'search', with: '2'
        click_on '検索'
        expect(page).to have_content 'test_title2'
        expect(page).not_to have_content 'test_title1'
      end
      it 'ステータス検索ができる' do
        visit tasks_path
        select '着手中', from: 'status'
        click_on '検索'
        expect(page).to have_content 'test_title1'
      end
      it 'タイトルとステータスの両方で検索ができる' do
        visit tasks_path
        fill_in 'search', with: 't'
        select '着手中', from: 'status'
        expect(page).to have_content 'test_title1'
      end
      it 'タグで検索した場合' do
        visit new_task_path
        fill_in 'text', with: "test_title3"
        fill_in 'content', with: "test_content3"
        check 'tag1'
        click_on 'タスクを追加する'
        select 'tag1', from: 'tag_id'
        click_on '検索'
        expect(page).to have_content 'test_title3'
        expect(page).not_to have_content 'test_title1'
      end
      it '詳細画面にタグが表示されていること' do
        visit new_task_path
        fill_in 'text', with: "test_title3"
        fill_in 'content', with: "test_content3"
        check 'tag1'
        binding.pry
        click_on 'タスクを追加する'
        click_on 'test_title3の詳細'
        expect(page).to have_content 'tag1'
      end
    end
  end

  describe '詳細表示機能' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:task) { FactoryBot.create(:task, user: user) }
    let!(:second_task) { FactoryBot.create(:second_task, user: user) }
    before do
      visit new_user_path
      fill_in 'user_name', with: user.name
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      fill_in 'user_password_confirmation', with: user.password
      click_on 'アカウントを作成する'
      visit new_session_path
      fill_in 'session_email', with: user.email
      fill_in 'session_password', with: user.password
      click_on 'ログインする'
    end
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        visit task_path(task)
        expect(page).to have_content 'test_title1'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        visit tasks_path
        expect(page.text).to match(/#{second_task.not_started_yet}[\s\S]*#{task.not_started_yet}/)
      end
    end
    context '終了期限でソートするを押した場合' do
      it '終了期限が一番近いタスクが一番上に表示される' do
        visit tasks_path
        click_on '終了期限'
        expect(page.text).to match(/#{task.not_started_yet}[\s\S]*#{second_task.not_started_yet}/)
      end
    end
    context '優先度でソートするを押した場合' do
      it '優先度が高いタスクが一番上に表示される' do
        visit tasks_path
        click_on '優先度'
        expect(page.text).to match(/#{task.not_started_yet}[\s\S]*#{second_task.not_started_yet}/)
      end
    end
  end
end