class CreateJobApplications < ActiveRecord::Migration
  def up
    create_table :job_applications do |t|
      t.belongs_to :user
      t.belongs_to :work_offer

      t.timestamps null: false
    end
  end

  def down
    drop_table :job_applications
  end
end
