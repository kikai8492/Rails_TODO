class TasksController < ApplicationController
  def index
    # @tasks = Task.all.order(created_at: :desc).page(params[:page])
    @tasks = current_user.tasks.order(created_at: :desc)
    if params[:sort_expired].present?#終了期限で並び替える時の処理
      # @tasks = Task.sort_expired.page(params[:page])
      @tasks = current_user.tasks.sort_expired
      # @tasks = @tasks.sort_expired
    end

    if params[:sort_priority].present?#優先順位で並び替える時の処理
      # @tasks = Task.sort_priority.page(params[:page])
      @tasks = current_user.tasks.sort_priority
      # @tasks = @tasks.sort_priority
    end

    # タスクのタイトルで検索するなら
    if params[:not_started_yet].present?
      @tasks = @tasks.not_started_yet(params[:not_started_yet])
    end

    # ステータスで検索するなら
    if params[:status].present?
      @tasks = @tasks.status(params[:status])
    end

    # 優先順位で検索するなら
    if params[:priority].present?
      @tasks = @tasks.priority(params[:priority])
    end

    if params[:tag_id].present? #index.html.erbの41行目のtag_idの値を取得している
      task_id = Tagging.where(tag_id: params[:tag_id]).pluck(:task_id) #タグのidを元にタスクのidを取得している
      @tasks = @tasks.where(id:task_id) #タスクのidを元にタスクを取得している
    end

    # @tasks = @tasks.page(params[:page])
    @tasks = Kaminari.paginate_array(@tasks).page(params[:page]).per(10)


    # if params[:not_started_yet].present? && params[:status].present? && params[:title].present? #タイトルとステータスとタグで検索する時の処理
    #   # @tasks = Task.not_started_yet_and_status(params[:not_started_yet], params[:status]).page(params[:page])
    #   @tasks = Task.not_started_yet_and_status_and_title(params[:not_started_yet], params[:status]), params[:title].page(params[:page])
    # elsif params[:not_started_yet].present? && params[:status].present? #タイトルとステータスで検索する時の処理
    #   @tasks = Task.not_started_yet_and_status(params[:not_started_yet], params[:status]).page(params[:page])
    # elsif params[:not_started_yet].present?
    #   @tasks = Task.not_started_yet(params[:not_started_yet]).page(params[:page])
    # elsif params[:status].present?
    #   @tasks = Task.status(params[:status]).page(params[:page])
    # else
    #   #ここの処理は3行目の処理と同じなので省略した
    # end
    
  end

  def new
    @task = Task.new
  end

  def create 
    @task = current_user.tasks.build(task_params) #アソシエーションの時はbuildを使う

    if @task.save
      redirect_to tasks_path, notice: "タスクを作成しました！"
    else
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
    if @task.user_id != current_user.id
      redirect_to tasks_path, notice: "他人のタスクは編集できません"
    end
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
    if @task.user_id != current_user.id
      redirect_to tasks_path, notice: "他人のタスクは閲覧できません"
    end
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
    params.require(:task).permit(:not_started_yet, :content, :expired_at, :status, :priority, tag_ids: [])
  end
end
