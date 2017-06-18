class GroupsController < ApplicationController
  before_action :get_group, only: [:show, :edit, :update, :destroy, :check_access_to_group]
  before_action :check_access_to_group, only: [:edit, :update, :destroy]

  def index
    @groups = current_user.groups
  end

  def new
    @group = Group.new
    @friends = current_user.friends
  end

  def edit
    @friends = current_user.friends
  end

  def show
    @groups = current_user.groups
    unless @groups.include?(@group)
      redirect_to groups_path, alert: 'You are not authorized to see this group'
    end
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
      redirect_to groups_path
    else
      render :new
    end
  end

  def update
    if @group.update_attributes(group_params)
      redirect_to groups_path
    else
      render :edit
    end
  end

  def destroy
    @group.destroy
    redirect_to groups_path
  end

  private

  def check_access_to_group
    unless @group.owner?(current_user)
      redirect_to groups_path, alert: 'You are not authorized to edit this group'
    end
  end

  def get_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, user_ids: [])
  end
end
