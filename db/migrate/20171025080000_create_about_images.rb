class CreateAboutImages < ActiveRecord::Migration
  def up
    create_table :about_images do |t|
      t.integer :position, limit: 1, default: 0
      t.integer :sort_order, limit: 1, default: 0


      t.timestamps null: false
    end

    add_attachment :about_images, :image_en
    add_attachment :about_images, :image_ru

    AboutImage.create_translation_table! image_caption: :string, image_credit: :string

    add_index :about_images, [:position, :sort_order]

  end

  def down
    AboutImage.drop_translation_table!
    drop_table :about_images
  end
end
