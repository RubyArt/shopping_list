class TasksController < ApplicationController
  before_action :get_group
  before_action :get_memberships, only: [:edit, :new]
  before_action :get_task, only: [:edit, :update, :destroy]

  def index
    @tasks = @group.tasks
  end

  def new
    @task = @group.tasks.new
  end

  def edit
  end

  def create
    @task = @group.tasks.new(task_params)
    @task.creator = current_user
    if @task.save
      redirect_to group_tasks_path(@group)
    else
      render :new
    end
  end

  def update
    if @task.update_attributes(task_params)
      redirect_to group_tasks_path(@group)
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to group_tasks_path(@group)
  end

  private

  def get_group
    @group = Group.find(params[:group_id])
  end

  def get_memberships
    @memberships = @group.memberships
  end

  def get_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:completed, :description, :name, :owner_id)
  end
end
