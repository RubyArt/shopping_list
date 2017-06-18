class Membership < ActiveRecord::Base
  belongs_to :user, inverse_of: :memberships, foreign_key: :user_id
  belongs_to :group, inverse_of: :memberships, foreign_key: :group_id

  validates :user, :group, presence: true

  def to_s
    user
  end
end
