class TasksManagerController < ApplicationController
  def index
    @uncompleted_tasks = current_user.tasks.uncompleted
    @completed_tasks = current_user.tasks.completed.limit(10)
  end

  def update
    @task = Task.find(params[:id])
    @was_completed = @task.completed?
    @task.toggle!(:completed)

    respond_to do |format|
      format.js { render 'update' }
    end
  end
end
