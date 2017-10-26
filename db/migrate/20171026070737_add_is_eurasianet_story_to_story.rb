class AddIsEurasianetStoryToStory < ActiveRecord::Migration
  def change
    add_column :stories, :is_eurasianet_story, :boolean, default: false
  end
end
