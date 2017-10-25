class AboutImage < ActiveRecord::Base
  #######################
  ## TRANSLATIONS

  translates :image_caption, :image_credit, :fallbacks_for_empty_translations => true
  # Allows reference of specific translations, i.e. post.title_az
  # or post.title_en
  globalize_accessors

  #######################
  ## ATTACHED FILE
  has_attached_file :image_en,
                    :url => "/system/about/:id/share/en/:style/:basename.:extension",
                    :styles => {
                        :'thumb' => {:geometry => "200>"}
                    },
                    :convert_options => {
                      :'thumb' => '-quality 85'
                    }

  has_attached_file :image_ru,
                    :url => "/system/about/:id/share/ka/:style/:basename.:extension",
                    :styles => {
                        :'thumb' => {:geometry => "200>"}
                    },
                    :convert_options => {
                      :'thumb' => '-quality 85'
                    }

  #######################
  ## VALIDATIONS

  validates :position, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than: 2 }
  validates_attachment :image_en,
    content_type: { content_type: ["image/jpeg", "image/png"] },
    size: { in: 0..4.megabytes }
  validates_attachment :image_ru,
    content_type: { content_type: ["image/jpeg", "image/png"] },
    size: { in: 0..4.megabytes }

  #######################
  ## SCOPES
  scope :sorted, -> { order('position asc, sort_order asc') }

  #######################
  ## METHODS

  def image(locale=I18n.locale)
    locale = locale.to_sym
    locale = I18n.locale if !I18n.available_locales.include?(locale)

    return locale == :en ? image_en : image_ru
  end

end
