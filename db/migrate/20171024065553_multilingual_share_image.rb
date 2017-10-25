class MultilingualShareImage < ActiveRecord::Migration
  def up

    add_attachment :stories, :image_share_ka
    add_attachment :stories, :image_share_en

    remove_attachment :stories, :image_share
  end

  def down
    remove_attachment :stories, :image_share_ka
    remove_attachment :stories, :image_share_en

    add_attachment :stories, :image_share
  end

end
