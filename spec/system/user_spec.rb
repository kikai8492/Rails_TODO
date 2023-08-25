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
    before do
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
      visit tasks_path
    end
    context 'ログインした場合' do
      it 'ログインができること' do
        expect(current_path).to eq tasks_path #タスク一覧画面に飛ぶことを期待する
      end
      it 'ログイン後、タスク一覧画面を通って自分の詳細画面に飛ぶこと' do
        click_on 'プロフィール'
        current_user = User.find_by(email: 'test1@icloud.com') #emailを見つけることはすなわちそのレコードすべてを持ってくるのでその中にidも含まれているから51行目でidが使える
        expect(current_path).to eq user_path(id: current_user.id) #自分の詳細画面に飛ぶことを期待する
      end
      it '一般ユーザが他人の詳細画面に飛ぶとタスク一覧画面に遷移すること' do
        click_on 'ログアウト' #test1でログイン中のため新しくアカウントを作るには一度ログアウトする必要がある
        visit new_user_path
        fill_in 'user_name', with: 'test2'
        fill_in 'user_email', with: 'test2@icloud.com'
        fill_in 'user_password', with: 'aaaaaa'
        fill_in 'user_password_confirmation', with: 'aaaaaa'
        click_on 'アカウントを作成する'
        visit new_session_path
        fill_in 'session_email', with: 'test2@icloud.com'
        fill_in 'session_password', with: 'aaaaaa'
        click_on 'ログインする'

        test1_id = User.find_by(email: 'test1@icloud.com') #emailを見つけることはすなわちそのレコードすべてを持ってくるのでその中にidも含まれているから51行目でidが使える
        visit user_path(id: test1_id.id)
        expect(current_path).not_to eq user_path(id: test1_id.id)
      end
      it 'ログアウトができること' do
        click_on 'ログアウト'
        expect(current_path).to eq new_session_path
      end
    end
  end

  describe '管理画面のテスト' do
    let!(:admin_user) {FactoryBot.create(:admin_user)}
    let!(:user) {FactoryBot.create(:user)}
    let!(:user2) {FactoryBot.create(:user2)}
    context '管理画面にアクセスした場合' do
      it '管理ユーザは管理画面にアクセスできること' do
        visit new_user_path
        fill_in 'user_name', with: admin_user.name
        fill_in 'user_email', with: admin_user.email
        fill_in 'user_password', with: admin_user.password
        fill_in 'user_password_confirmation', with: admin_user.password
        click_on 'アカウントを作成する'
        visit new_session_path
        fill_in 'session_email', with: admin_user.email
        fill_in 'session_password', with: admin_user.password
        click_on 'ログインする'
        
        visit admin_users_path
        expect(current_path).to eq admin_users_path
      end
      it '一般ユーザは管理画面にアクセスできないこと' do
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
        
        visit admin_users_path
        expect(current_path).not_to eq admin_users_path
      end
      it '管理ユーザはユーザの新規登録ができること' do
        visit new_user_path
        fill_in 'user_name', with: admin_user.name
        fill_in 'user_email', with: admin_user.email
        fill_in 'user_password', with: admin_user.password
        fill_in 'user_password_confirmation', with: admin_user.password
        click_on 'アカウントを作成する'
        visit new_session_path
        fill_in 'session_email', with: admin_user.email
        fill_in 'session_password', with: admin_user.password
        click_on 'ログインする'
        
        visit admin_users_path
        click_on "ユーザーを新規登録する"
        visit new_admin_user_path
        fill_in 'user_name', with: user.name
        fill_in 'user_email', with: user.email
        fill_in 'user_password', with: user.password
        fill_in 'user_password_confirmation', with: user.password
        click_on 'アカウントを作成する'
        
        visit admin_users_path
        expect(current_path).to eq admin_users_path
        expect(page).to have_content 'test1'
      end
      it '管理ユーザはユーザの詳細画面にアクセスできること' do
        visit new_user_path
        fill_in 'user_name', with: admin_user.name
        fill_in 'user_email', with: admin_user.email
        fill_in 'user_password', with: admin_user.password
        fill_in 'user_password_confirmation', with: admin_user.password
        click_on 'アカウントを作成する'
        visit new_session_path
        fill_in 'session_email', with: admin_user.email
        fill_in 'session_password', with: admin_user.password
        click_on 'ログインする'
        
        visit admin_users_path
        click_on 'kikaiの詳細'
        current_user = User.find_by(email: admin_user.email)
        expect(current_path).to eq admin_user_path(id: current_user.id)
      end
      it '管理ユーザはユーザの編集画面からユーザを編集できること' do
        visit new_user_path
        fill_in 'user_name', with: admin_user.name
        fill_in 'user_email', with: admin_user.email
        fill_in 'user_password', with: admin_user.password
        fill_in 'user_password_confirmation', with: admin_user.password
        click_on 'アカウントを作成する'
        visit new_session_path
        fill_in 'session_email', with: admin_user.email
        fill_in 'session_password', with: admin_user.password
        click_on 'ログインする'
        
      
        visit admin_users_path
        click_on 'test1の編集'
        

        edit_user = User.find_by(email: user.email)
        visit edit_admin_user_path(id: edit_user.id)
        fill_in 'user_name', with: 'test3'
        fill_in 'user_email', with: 'test3@icloud.com'
        fill_in 'user_password', with: 'aaaaaa'
        fill_in 'user_password_confirmation', with: 'aaaaaa'
        
        click_on 'アカウントを作成する'
        # find('input[name="commit"]').click
        visit admin_users_path
        expect(page).to have_content 'test3'
      end
    end
  end
end