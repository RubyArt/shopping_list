class Group < ActiveRecord::Base
  after_destroy {|group| Membership.destroy(group.memberships.pluck(:id)) }

  has_many :memberships, inverse_of: :group
  has_many :users, through: :memberships
  belongs_to :owner, class_name: 'User'

  validates :name, :memberships, :owner_id, presence: true
  validates :name, uniqueness: { scope: :owner_id, message: 'This group already exists!' }

  def set_owner!(user)
    self.owner_id = user.id
    self.save!
  end
end
