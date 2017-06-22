class Invitation < ApplicationRecord
  belongs_to :receiver, class_name: 'User', foreign_key: :receiver_id
  belongs_to :sender, class_name: 'User', foreign_key: :sender_id

  validates :receiver_id, :sender_id, presence: true

  scope :not_answered, -> { where(accepted_at: nil, declined_at: nil) }
end
