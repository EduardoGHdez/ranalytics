class CreateGitHubEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :git_hub_events do |t|
      t.bigint :event_id, index: true, null: false
      t.string :type
      t.boolean :public

      t.timestamps
    end

    add_index :git_hub_events, :type
  end
end
