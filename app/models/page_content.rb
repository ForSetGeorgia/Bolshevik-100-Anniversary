# == Schema Information
#
# Table name: page_contents
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PageContent < AddMissingTranslation

  #######################
  ## TRANSLATIONS

  translates :title, :content, :fallbacks_for_empty_translations => true
  # Allows reference of specific translations, i.e. post.title_az
  # or post.title_en
  globalize_accessors

  #######################
  ## VALIDATIONS

  validates :name, presence: :true, uniqueness: :true

  #######################
  ## SCOPES
  scope :only_title, -> { with_translations(I18n.locale).select('page_contents.name, page_content_translations.title') }

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
