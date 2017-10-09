class CreateStories < ActiveRecord::Migration
  def up
    create_table :stories do |t|
      t.boolean :is_published, default: false
      t.date :published_at
      t.string :slug

      t.timestamps null: false
    end

    add_attachment :stories, :image_homepage
    add_attachment :stories, :image_share
    add_attachment :stories, :image_story

    Story.create_translation_table! title: :string, content: :text, author: :string, image_caption: :string, image_credit: :string, slug: :string

    add_index :stories, :slug, unique: true
    add_index :stories, [:is_published, :published_at]
    add_index :story_translations, :slug
    add_index :story_translations, :title

  end

  def down
    Story.drop_translation_table!
    drop_table :stories
  end
end
