class FixImageShareRu < ActiveRecord::Migration
  def up

    add_attachment :stories, :image_share_ru
    remove_attachment :stories, :image_share_ka
  end

  def down
    remove_attachment :stories, :image_share_ru
    add_attachment :stories, :image_share_ka
  end
end
