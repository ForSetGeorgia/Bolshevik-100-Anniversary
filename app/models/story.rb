# == Schema Information
#
# Table name: stories
#
#  id                          :integer          not null, primary key
#  is_published                :boolean          default(FALSE)
#  published_at                :date
#  slug                        :string(255)
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  image_homepage_file_name    :string(255)
#  image_homepage_content_type :string(255)
#  image_homepage_file_size    :integer
#  image_homepage_updated_at   :datetime
#  image_share_file_name       :string(255)
#  image_share_content_type    :string(255)
#  image_share_file_size       :integer
#  image_share_updated_at      :datetime
#  image_story_file_name       :string(255)
#  image_story_content_type    :string(255)
#  image_story_file_size       :integer
#  image_story_updated_at      :datetime
#  sort_order                  :integer          default(1)
#

class Story < AddMissingTranslation
  #######################
  ## TRANSLATIONS

  translates :title, :content, :author, :image_caption, :image_credit, :slug,
              :title_share, :description_share, :title_home, :author_organization,
              :subheader, :footnotes,
              :fallbacks_for_empty_translations => true
  # Allows reference of specific translations, i.e. post.title_az
  # or post.title_en
  globalize_accessors

  #######################
  ## SLUGS
  extend FriendlyId
  friendly_id :title, :use => [:globalize, :slugged, :history]

  # for genereate friendly_id
  def should_generate_new_friendly_id?
#    name_changed? || super
    super
  end

  # for locale sensitive transliteration with friendly_id
  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize.to_s
  end


  #######################
  ## ATTACHED FILE
  has_attached_file :image_homepage,
                    :url => "/system/story/:id/homepage/:style/:basename.:extension"

  has_attached_file :image_share_en,
                    :url => "/system/story/:id/share/en/:style/:basename.:extension",
                    :styles => {
                        :'thumb' => {:geometry => "200>"}
                    },
                    :convert_options => {
                      :'thumb' => '-quality 85'
                    }

  has_attached_file :image_share_ru,
                    :url => "/system/story/:id/share/ru/:style/:basename.:extension",
                    :styles => {
                        :'thumb' => {:geometry => "200>"}
                    },
                    :convert_options => {
                      :'thumb' => '-quality 85'
                    }

  has_attached_file :image_story,
                    :url => "/system/story/:id/story/:style/:basename.:extension",
                    :styles => {
                        :'thumb' => {:geometry => "200>"},
                        :'pagination' => ""
                    },
                    :convert_options => {
                      :'thumb' => '-quality 85',
                      :'pagination' => '-gravity north -thumbnail 130x130^ -extent 130x130'
                    }

  #######################
  ## VALIDATIONS

  validates :title, presence: :true
  validates_attachment :image_homepage,
    content_type: { content_type: ["image/jpeg", "image/png"] },
    size: { in: 0..4.megabytes }
  validates_attachment :image_share_en,
    content_type: { content_type: ["image/jpeg", "image/png"] },
    size: { in: 0..4.megabytes }
  validates_attachment :image_share_ru,
    content_type: { content_type: ["image/jpeg", "image/png"] },
    size: { in: 0..4.megabytes }
  validates_attachment :image_story,
    content_type: { content_type: ["image/jpeg", "image/png"] },
    size: { in: 0..4.megabytes }

  #######################
  ## SCOPES
  scope :published, -> { where(is_published: true) }
  scope :sorted, -> { order('stories.sort_order asc, stories.published_at asc') } # with_translations(I18n.locale). , story_translations.title asc
  scope :only_title, -> { with_translations(I18n.locale).select('stories.slug, stories.id, story_translations.title, story_translations.slug') }
  scope :without_eurasianet_story, -> { where(is_eurasianet_story: false) }

  #######################
  ## METHODS

  def author_info
    x = self.author
    if self.author_organization.present?
      x << " (#{self.author_organization})"
    end
    return x
  end

  def image_share(locale=I18n.locale)
    locale = locale.to_sym
    locale = I18n.locale if !I18n.available_locales.include?(locale)

    return locale == :en ? image_share_en : image_share_ru
  end


  #######################
  #######################
  private

  def has_required_translations?(trans)
    trans.title.present?
  end

  def add_missing_translations(default_trans)
    self.title = default_trans.title if self["title_#{Globalize.locale}"].blank?
  end

end
