class TasksController < ApplicationController
  def index
    @tasks = Task.all.order(created_at: :desc)
    if params[:sort_expired].present?
      @tasks = Task.all.order(expired_at: :asc)
    end

    if params[:not_started_yet].present?
      @tasks = Task.where('not_started_yet LIKE(?)', "%#{params[:not_started_yet]}%")
    end
  end

  def new
    @task = Task.new
  end

  def create 
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: "タスクを作成しました！"
    else
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
  end


  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to tasks_path, notice: "タスクを編集しました！"
    else
      render :edit
    end
  end

  def show
    @task = Task.find(params[:id])
  end



  def destroy
    @task = Task.find(params[:id])
    if @task.destroy
      redirect_to tasks_path, notice: "タスクを削除しました！"
    else
      render :index
    end
  end

  private

  def task_params
    params.require(:task).permit(:not_started_yet, :content, :expired_at, :status)
  end
end
