class TasksManagerController < ApplicationController
  def index
    @completed_tasks = current_user.tasks.completed
    @uncompleted_tasks = current_user.tasks.uncompleted
  end
end
