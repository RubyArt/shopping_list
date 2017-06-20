class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :groups, through: :memberships
  has_many :memberships, inverse_of: :user
  has_many :owned_groups, class_name: 'Group', foreign_key: :owner_id
  has_many :tasks, through: :groups # Do you need this association?
  has_many :sent_invitations, class_name: 'Invitation', foreign_key: :sender_id
  has_many :received_invitations, class_name: 'Invitation', foreign_key: :receiver_id

  validates :email, :first_name, :last_name, presence: true

  def friends
    User.where(id: Friendship.for_user(self).map do |friendship|
                 [friendship.sender_id, friendship.receiver_id]
               end.flatten.uniq - [self.id])
  end

  def not_friends
    User.all - friends - [self]
  end

  def is_a_friend_with?(user)
    friends.include?(user)
  end

  def to_s
    "#{first_name} #{last_name}"
  end
end
