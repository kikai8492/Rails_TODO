class Admin::UsersController < ApplicationController
  def index
    @users = User.all.includes(:tasks).order(id: "ASC")
    if current_user.admin == false #usersテーブルのadminカラムがfalseの場合は管理者画面へのアクセスを禁止してタスク一覧画面にリダイレクトする
      redirect_to tasks_path, notice: "管理者以外はアクセスできません"
    end
  end

  def new
    @user = User.new 
    if current_user.admin == false
      redirect_to tasks_path, notice: "管理者以外はアクセスできません"
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: "管理者がユーザーを登録しました！"
    else
      render :new, notice: "管理者ユーザー登録に失敗しました"
    end
  end

  def edit
    @user = User.find(params[:id])
    if current_user.admin == false
      redirect_to tasks_path, notice: "管理者以外はアクセスできません"
    end
  end

  def update
    @user= User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "管理者ユーザー情報を編集しました！"
    else
      render :edit, notice: "管理者ユーザー情報の編集に失敗しました"
    end
  end

  def show 
    @user = User.find(params[:id])
    if current_user.admin == false
      redirect_to tasks_path, notice: "管理者以外はアクセスできません"
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to admin_users_path, notice: "管理者がユーザーを削除しました！"
    else
      redirect_to admin_users_path, notice: "管理者は最低でも一人以上必要なので削除できませんでした" #renderは使うとパスが変わるのでredirect_toを使う
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end
end
