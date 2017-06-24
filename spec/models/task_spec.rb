require 'rails_helper'

describe Task do
  describe '.save' do
    it 'sets "completed_at" to current time if "completed" is changed to true' do
      task = create(:task)

      expect { task.update_attribute(:completed, true) }.to(change { task.reload.completed_at }.from(nil))
    end

    it 'sets "completed_at" to nil if "completed" is changed to false' do
      task = create(:task, :completed)

      expect { task.update_attribute(:completed, false) }.to(change { task.reload.completed_at }.to(nil))
    end

    it 'does not change "completed_at if "completed" is not changed' do
      task = create(:task, :completed)

      expect { task.update_attribute(:name, 'important task') }.not_to(change { task.reload.completed_at })
      expect { task.update_attribute(:completed, true) }.not_to(change { task.reload.completed_at })
    end
  end
end
