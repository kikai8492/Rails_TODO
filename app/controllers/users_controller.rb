class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create] #ログインしていなくてもnewとcreateは実行できるようにする
  def new
    @user = User.new
    if logged_in?
      redirect_to tasks_path, notice: "ログイン中はユーザーの新規登録できません"
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to tasks_path, notice: "ユーザー登録が完了しました！"
    else
      render :new, notice: "ユーザー登録に失敗しました"
    end
  end

  def edit
    @user = User.find(params[:id])
    if @user.id != current_user.id
      redirect_to tasks_path, notice: "他人の情報は編集できません"
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to tasks_path, notice: "ユーザー情報を編集しました！"
    else
      render :edit, notice: "ユーザー情報の編集に失敗しました"
    end
  end

  def show
    @user = User.find(params[:id])
    if current_user.id != @user.id
      redirect_to tasks_path, notice: "他人の情報は閲覧できません"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
