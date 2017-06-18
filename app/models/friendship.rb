class Friendship < ActiveRecord::Base
  belongs_to :receiver, class_name: 'User', foreign_key: :receiver_id
  belongs_to :sender, class_name: 'User', foreign_key: :sender_id

  validates :receiver_id, :sender_id, presence: true

  def self.for_user(user)
    where('sender_id = :user_id OR receiver_id = :user_id', {user_id: user.id})
  end
end

