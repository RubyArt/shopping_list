class TasksController < ApplicationController
  before_action :group
  before_action :task, only: %i[edit update destroy]
  before_action :check_access_to_task

  def new
    @task = @group.tasks.new
  end

  def edit; end

  def create
    @task = @group.tasks.new(task_params)
    @task.creator = current_user
    if @task.save
      redirect_to group_path(@group)
    else
      render :new
    end
  end

  def update
    if @task.update_attributes(task_params)
      redirect_to group_path(@group)
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to group_path(@group)
  end

  private

  def group
    @group = Group.find(params[:group_id])
  end

  def task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:completed, :description, :name, :owner_id)
  end

  def check_access_to_task
    unless @group.member?(current_user)
      redirect_to root_path, alert: 'You are not authorized to create/edit task for this group'
    end
  end
end
