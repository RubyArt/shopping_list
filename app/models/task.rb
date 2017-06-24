class Task < ApplicationRecord
  belongs_to :group, inverse_of: :tasks
  belongs_to :creator, class_name: 'User', foreign_key: :creator_id
  belongs_to :owner, class_name: 'User', foreign_key: :owner_id, optional: true

  validates :name, :group_id, presence: true

  after_save :set_accepted_at

  scope :completed, -> { where(completed: true).order(completed_at: :desc) }
  scope :uncompleted, -> { where(completed: false).order(created_at: :desc) }

  private

  def set_accepted_at
    if completed_changed?
      if completed?
        update_column(:completed_at, Time.current)
      else
        update_column(:completed_at, nil)
      end
    end
  end
end
