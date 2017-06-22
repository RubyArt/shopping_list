class Group < ActiveRecord::Base
  has_many :memberships, inverse_of: :group, dependent: :destroy
  has_many :users, through: :memberships
  has_many :tasks, inverse_of: :group, dependent: :destroy
  belongs_to :owner, class_name: 'User'

  validates :name, :owner_id, presence: true
  validates :name, uniqueness: { scope: :owner_id, message: 'This group already exists!' }

  before_save :add_membership_for_owner

  def owner?(user)
    owner_id == user.id
  end

  def to_s
    name
  end

  private

  def add_membership_for_owner
    self.user_ids = (user_ids << owner_id).uniq
  end
end
