class CreateGitHubEventHourlyQueues < ActiveRecord::Migration[6.1]
  def change
    create_table :git_hub_event_hourly_queues do |t|
      t.string :type
      t.bigint :count
      t.datetime :date

      t.timestamps
    end

    add_index :git_hub_event_hourly_queues, :type
  end
end
