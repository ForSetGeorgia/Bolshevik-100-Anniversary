

require 'fileutils'


namespace :populate do
  desc "Read and upload all annual files"
  task :stories => :environment do |t, args|
    I18n.locale = :en

    dummy_text = "<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>"
    Story.destroy_all
    stories = [
      { title: { en: "Bolshevism's Impact on the Russian Orthodox Church", ru: "" }, author: { en: "Christopher Stroop", ru: "" } },
      { title: { en: "The Revolution and Islam", ru: "" }, author: { en: "Edward Lemmon", ru: "" } },
      { title: { en: "The Bolshevik Revolution and the Politics of Memory", ru: "" }, is_wide: true, author: { en: "Chris Miller", ru: "" } },
      { title: { en: "The Revolution in Central Asia", ru: "" }, author: { en: "Alexander Morrison", ru: "" } },
      { title: { en: "The impact of 1917 on the Baltics", ru: "" }, author: { en: "Lauri Mälksoo", ru: "" } },
      { title: { en: "Bolshevism and the Caucasus", ru: "" }, author: { en: "Thomas de Waal", ru: "" } },
      { title: { en: "Bolshevism: What Might Have Been", ru: "" }, author: { en: "Tarik Cyril Amar", ru: "" } },
      { title: { en: "Bolshevism and Gender: A Contested Legacy", ru: "" }, author: { en: "Philippa Heatherington", ru: "" } },
      { title: { en: "The Legacy of 1917 for the Rule of Law", ru: "" }, author: { en: "Dmitry Dubrovsky", ru: "" } },
      { title: { en: "Bolshevism's Legacy for the Oil Industry", ru: "" }, is_wide: true, author: { en: "Doug Rogers", ru: "" } },
      { title: { en: "A Legacy of 1917: A Lingering Imperial Situation", ru: "" }, author: { en: "Unknown", ru: "" } }
    ]

    stories.each_with_index {|story, story_i|
      image = File.new("#{Rails.root}/public/_stories/home/#{story_i+1}.jpg", "r")
      image_share = File.new("#{Rails.root}/public/_stories/share/#{I18n.locale}/#{story_i+1}.jpg", "r")
      image_story = File.new("#{Rails.root}/public/_stories/story/#{story_i+1}.jpg", "r")
      puts image.inspect
      puts story[:title][:en]
      I18n.locale = :en
      s = Story.create(
        title: story[:title][:en],
        title_home: story[:title][:en],
        title_share: story[:title][:en],
        description_share: story[:title][:en],
        content: dummy_text,
        author: story[:author][:en],
        sort_order: story_i + 1,
        image_caption: story[:title][:en],
        image_credit: "Image Credit",
        author_organization: "Eurasianet",
        subheader: "Subheader",
        footnotes: "Footnotes",
        image_homepage: image,
        image_share: image_share,
        image_story:image_story,
        is_wide: story[:is_wide].present?,
        is_published: [0, 1].sample
      )
      I18n.locale = :ru
      image_share = File.new("#{Rails.root}/public/_stories/share/#{I18n.locale}/#{story_i+1}.jpg", "r")
      s.image_share = image_share
      s.save
      if !s.valid?
        puts s.errors.inspect
      end

    }
  end
end
