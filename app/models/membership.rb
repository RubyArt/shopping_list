class Membership < ApplicationRecord
  belongs_to :user, inverse_of: :memberships, foreign_key: :user_id
  belongs_to :group, inverse_of: :memberships, foreign_key: :group_id

  validates :user, :group, presence: true
  validates :user_id, uniqueness: { scope: :group_id }

  def to_s
    user
  end
end
