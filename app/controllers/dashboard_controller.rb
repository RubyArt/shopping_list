class DashboardController < ApplicationController
  def index; end

  def user_data
    data = [
      ['All tasks', current_user.tasks.count],
      ['Completed tasks', current_user.tasks.completed.count],
      ['Uncompleted tasks', current_user.tasks.uncompleted.count],
      ['Owned groups', Group.where(owner_id: current_user.id).count],
      ['Friends', current_user.friends.count]
    ]

    respond_to do |format|
      format.json { render json: data.to_json }
    end
  end
end
