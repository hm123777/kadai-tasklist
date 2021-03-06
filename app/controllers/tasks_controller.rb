class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:show, :edit, :update, :destroy]

  def index
    # @tasks = Task.all
    @tasks = current_user.tasks.all
  end

  def show
  end

  def new
    # @task = Task.new
    @task = current_user.tasks.build
  end

  def create
    # @task = Task.new(task_params)
    @task = current_user.tasks.build(task_params)

    if @task.save
      flash[:success] = 'タスク が正常に投稿されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスク が投稿されませんでした'
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      flash[:success] = 'タスク は正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスク は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @task.destroy

    flash[:success] = 'タスク は正常に削除されました'
    redirect_to tasks_url
  end
  
  private

  def set_task
    @task = Task.find(params[:id])
  end

private

  # Strong Parameter

  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def correct_user
    redirect_to root_url if @task.user != current_user
  end
  
end
