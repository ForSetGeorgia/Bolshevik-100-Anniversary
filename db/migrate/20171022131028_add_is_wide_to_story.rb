class AddIsWideToStory < ActiveRecord::Migration
  def change
    add_column :stories, :is_wide, :boolean, default: false
  end
end
