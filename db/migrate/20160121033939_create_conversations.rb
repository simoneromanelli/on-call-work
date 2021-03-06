class CreateConversations < ActiveRecord::Migration
  def up
    create_table :conversations do |t|
      t.integer :sender_id
      t.integer :recipient_id
      t.boolean :archived, default: false

      t.timestamps null: false
    end
  end

  def down
    drop_table :conversations
  end
end
