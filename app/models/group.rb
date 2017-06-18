class Group < ActiveRecord::Base
  after_destroy { |group| Membership.destroy(group.memberships.pluck(:id)) }
  after_save { |group| Membership.create(group_id: group.id, user_id: group.owner_id)}

  has_many :memberships, inverse_of: :group
  has_many :users, through: :memberships
  has_many :tasks, inverse_of: :group
  belongs_to :owner, class_name: 'User'

  validates :name, :owner_id, presence: true
  validates :name, uniqueness: {scope: :owner_id, message: 'This group already exists!'}

  def owner?(user)
    owner_id == user.id
  end
end
