class AddMoreFields < ActiveRecord::Migration
  def change
    add_column :story_translations, :title_share, :string
    add_column :story_translations, :description_share, :string
    add_column :story_translations, :title_home, :string
    add_column :story_translations, :author_organization, :string
    add_column :story_translations, :subheader, :string
    add_column :story_translations, :footnotes, :text

    add_column :stories, :sort_order, :integer, limit: 1, default: 1
    add_index :stories, :sort_order

  end
end
