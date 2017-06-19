class CreateInvitations < ActiveRecord::Migration[5.0]
  def change
    create_table :invitations do |t|
      t.integer :receiver_id
      t.integer :sender_id
      t.datetime :accepted_at
      t.datetime :declined_at
      t.timestamps
    end
  end
end
