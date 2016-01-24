class CreateMessages < ActiveRecord::Migration
  def up
    create_table :messages do |t|
      t.text :text
      t.references :conversation
      t.references :user
      t.boolean :read, default: false

      t.timestamps null: false
    end
  end

  def down
    drop_table :messages
  end
end