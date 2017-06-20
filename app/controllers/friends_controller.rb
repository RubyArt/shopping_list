class FriendsController < ApplicationController

  def index
    @friends = current_user.friends
  end

  def new
    @not_friends = current_user.not_friends
  end

  def create
    Invitation.create(sender_id: current_user.id, receiver_id: params[:receiver_id])
    redirect_to friends_path
  end
end
