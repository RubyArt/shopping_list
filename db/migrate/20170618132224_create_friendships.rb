class CreateFriendships < ActiveRecord::Migration[5.0]
  def change
    create_table :friendships do |t|
      t.integer :receiver_id
      t.integer :sender_id
      t.timestamps
    end
  end
end
