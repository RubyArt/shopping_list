class InvitationMailer < ApplicationMailer
  def invitation_message(invitation)
    @invitation = invitation
    @sender = invitation.sender
    @receiver = invitation.receiver

    mail(to: @receiver.email,
         subject: "You have been invited as a friend by #{@sender} on TasksManager!")
  end
end
