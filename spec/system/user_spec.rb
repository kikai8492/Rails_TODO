require 'rails_helper'
RSpec.describe 'ユーザー機能', type: :system do

  describe 'ユーザー登録のテスト' do
    context 'ユーザーの新規登録をした場合' do
      it 'ユーザーの新規登録及びにタスク一覧画面に飛ぶこと' do
        visit new_user_path
        fill_in 'user_name', with: 'test1'
        fill_in 'user_email', with: 'test1@icloud.com'
        fill_in 'user_password', with: 'aaaaaa'
        fill_in 'user_password_confirmation', with: 'aaaaaa'
        
        click_on 'アカウントを作成する'
        expect(current_path).to eq tasks_path #tasks_pathに飛ぶことを期待する
      end
    end
    context 'ログインせずにタスク一覧画面に飛ぼうとした場合' do
      it 'ログイン画面に遷移すること' do
        visit tasks_path
        expect(current_path).to eq new_session_path #new_session_pathに飛ぶことを期待する
      end
    end
  end

  describe 'セッション機能のテスト' do
    context 'ログインした場合' do
      it 'ログインができること' do
        visit new_user_path
        fill_in 'user_name', with: 'test1'
        fill_in 'user_email', with: 'test1@icloud.com'
        fill_in 'user_password', with: 'aaaaaa'
        fill_in 'user_password_confirmation', with: 'aaaaaa'
        click_on 'アカウントを作成する'
        visit new_session_path
        fill_in 'session_email', with: 'test1@icloud.com'
        fill_in 'session_password', with: 'aaaaaa'
        click_on 'ログインする'
        expect(current_path).to eq tasks_path #タスク一覧画面に飛ぶことを期待する
        expect(page).to have_content 'タスク名'
      end
      it 'ログイン後、タスク一覧画面を通って自分の詳細画面に飛ぶこと' do
        visit new_session_path
        fill_in 'session_email', with: 'test1@icloud.com'
        fill_in 'session_password', with: 'aaaaaa'
        click_on 'ログインする'
        visit tasks_path
        click_on 'プロフィール'
        expect(current_path).to eq user_path #自分の詳細画面に飛ぶことを期待する
      end
    end
  end
end