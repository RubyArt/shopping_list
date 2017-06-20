class InvitationsController < ApplicationController
  def index
    @sent_invitations = current_user.sent_invitations.not_answered
    @received_invitations = current_user.received_invitations.not_answered
  end

  def accept
    invitation = Invitation.find(params[:id])
    invitation.update_attributes(accepted_at: DateTime.now)
    Friendship.create(sender_id: invitation.sender_id, receiver_id: invitation.receiver_id)
    redirect_to invitations_path
  end

  def decline
    Invitation.find(params[:id]).update_attributes(declined_at: DateTime.now)
    redirect_to invitations_path
  end
end
