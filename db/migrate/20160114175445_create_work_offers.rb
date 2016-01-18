class CreateWorkOffers < ActiveRecord::Migration
  def up
    create_table :work_offers do |t|
      t.string :title
      t.text :description
      t.string :company_name
      t.timestamp :date_time
      t.belongs_to :bidder, index: true
      t.belongs_to :elected, index: true

      t.timestamps null: false
    end
  end

  def down
    drop_table :work_offers
  end
end
