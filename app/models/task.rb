class Task < ActiveRecord::Base
  belongs_to :group, inverse_of: :tasks
  belongs_to :creator, class_name: 'User', foreign_key: :creator_id
  belongs_to :owner, class_name: 'User', foreign_key: :owner_id, optional: true

  validates :name, :group_id, presence: true
end
