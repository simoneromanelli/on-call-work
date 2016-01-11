class CreateFeedbacks < ActiveRecord::Migration
  def up
    create_table :feedbacks do |t|
      t.belongs_to :subject, index: true
      t.belongs_to :writer, index: true
      t.belongs_to :work_offer, index: true
      t.text :text
      t.integer :rating

      t.timestamps null: false
    end
  end

  def down
    drop_table :feedbacks
  end
end
