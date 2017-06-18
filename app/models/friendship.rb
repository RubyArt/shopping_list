class Friendship < ActiveRecord::Base
  belongs_to :receiver, class_name: 'User'
  belongs_to :sender, class_name: 'User'
  has_many :users, inverse_of: :friendship

  validates :receiver_id, :sender_id, presence: true
end
