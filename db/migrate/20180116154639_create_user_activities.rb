class CreateUserActivities < ActiveRecord::Migration[5.1]
  def change
    create_table :user_activities do |t|
      t.references :user
      t.references :activity
      t.datetime  :start_time
      t.datetime  :end_time

      t.timestamps
    end
  end
end
