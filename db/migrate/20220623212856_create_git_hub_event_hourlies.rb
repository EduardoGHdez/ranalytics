class CreateGitHubEventHourlies < ActiveRecord::Migration[6.1]
  def change
    create_view :git_hub_event_hourlies
  end
end
