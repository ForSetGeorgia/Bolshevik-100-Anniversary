# This file should contain all the record creation needed to seed the database
# with its default values. The data can then be loaded with the rake db:seed
# (or created alongside the db with db:setup).

roles = %w(super_admin site_admin content_manager)
roles.each do |role|
  Role.find_or_create_by(name: role)
end

# if this is not production
# and variable is set, create users if not exist
if ENV['create_user_accounts'].present? && !Rails.env.production?
  puts "LOADING TEST USER ACCOUNTS"
  User.find_or_create_by(email: 'super.admin@test.ge') do |u|
    puts "creating super admin"
    u.password = 'password123'
    u.role_id = 1
  end

  User.find_or_create_by(email: 'site.admin@test.ge') do |u|
    puts "creating site admin"
    u.password = 'password123'
    u.role_id = 2
  end

  User.find_or_create_by(email: 'content.manager@test.ge') do |u|
    puts "creating content manager"
    u.password = 'password123'
    u.role_id = 3
  end
end

# load page content records with placeholder text
# project about
puts 'Destory page content'
PageContent.destroy_all
puts 'creating page content for about'
p = PageContent.create(
  name: 'about',
  title: 'About The Red Legacy',
  content:  "<p>The Bolshevik coup occurred on October 25 or November 7, 1917, depending on what calendar you go by. It was a revolution by no means accomplished in a day - some argue it took over a decade to play out. It ended up bequeathing to the world Soviet-style communism.</p><p>The centennial of what Soviet historians portrayed as the Great October Socialist Revolution is not receiving much attention in Russia today. But regardless of how it is being publicly commemorated there, it remains one of the key pivot points of the 20th century --an event that shaped international relations for subsequent decades, and which continues to exert tremendous social, economic and political influence over Eurasia.</p><p>A more thorough understanding of the October Revolution's impact can be helpful in making sense of current affairs. Thus, <a href='http://www.eurasianet.org/' target='_blank'>Eurasianet</a> is presenting The Red Legacy, a special project in which leading scholars and experts from the United States, Europe and Russia examine various aspects of the October Revolution and highlight trends and issues that connect the past to the present.</p><p>The Red Legacy gets its name from the red banner of communism under which Vladimir Lenin and his cohorts acted in 1917, and from the Red Army, which kept the Bolsheviks in power during the tumultuous years that followed their seizure of power.</p><p>Starting on October 25, Eurasianet will add an analysis article every day to The Red Legacy until November 7. We hope you enjoy it.</p>"
)
Globalize.with_locale(:ru) do
  p.title = "О проекте «Наследие Октября»"
  p.save
end

puts 'Destory about images'
AboutImage.destroy_all

puts 'Create about images'
[1,2,3,4,5].each {|e|
  AboutImage.create(
  image_caption: '',
  image_credit: '',
  position: e > 2 ? 1 : 0,
  image_en: File.new("#{Rails.root}/public/_about/#{e}.jpg", "r"),
  image_ru: File.new("#{Rails.root}/public/_about/#{e}.jpg", "r"))
}


require 'fileutils'
I18n.locale = :en
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
  { title: { en: "A Legacy of 1917: A Lingering Imperial Situation", ru: "" }, author: { en: "Unknown", ru: "" } },
  # eurasianet about
  { title: { en: "About EurasiaNet.org", ru: "О сайте EurasiaNet.org" }, author: { en: nil, ru: nil }, image_id: 99, content: { en: '<p>Eurasianet is a non-profit, independent news organization that produces features and analysis about contemporary developments in Eurasia.</p><p>We present a variety of perspectives about these developments, utilizing a network of correspondents based both in the West and in the region. We strive to fulfill a traditional watchdog function, publishing stories that provide useful context for ongoing policy debates, while seeking to hold authorities accountable for their actions.</p><p>Based in New York, Eurasianet is hosted by Columbia University’s Harriman Institute, one of the leading centers in North America of scholarship concerning Eurasia.</p><p>Find us on <a href="https://twitter.com/EurasiaNet" target="_blank">Twitter</a>, <a href="https://www.facebook.com/EurasiaNet/" target="_blank">Facebook</a>, <a href="https://www.instagram.com/eurasianet/" target="_blank">Instagram</a>, <a href="https://www.youtube.com/channel/UCguYqb3BpHecqB5UPuuKd4Q" target="_blank">YouTube</a>, and at <a href="http://eurasianet.org/" target="_blank">Eurasianet.org</a>.</p>', ru: "" }, is_eurasianet_story: true }
]

stories.each_with_index {|story, story_i|
  image_id = story[:image_id].present? ? story[:image_id] : story_i+1
  is_eurasianet_story = story[:is_eurasianet_story].present?
  content = story[:content].present? && story[:content][:en].present? ? story[:content][:en] : ''
  image = File.new("#{Rails.root}/public/_stories/home/#{image_id}.jpg", "r")
  image_story = File.new("#{Rails.root}/public/_stories/story/#{image_id}.jpg", "r")
  # puts image.inspect
  # puts story[:title][:en]
  I18n.locale = :en
  s = Story.create(
    title: story[:title][:en],
    title_home: story[:title][:en],
    title_share: story[:title][:en],
    # description_share: story[:title][:en],
    content: content,
    author: story[:author][:en],
    sort_order: story_i + 1,
    image_caption: story[:title][:en],
    # image_credit: nil,
    # author_organization: "Eurasianet",
    # subheader: "Subheader",
    # footnotes: "Footnotes",
    image_homepage: image,
    image_share_en: File.new("#{Rails.root}/public/_stories/share/en/#{image_id}.jpg", "r"),
    image_share_ru: File.new("#{Rails.root}/public/_stories/share/ru/#{image_id}.jpg", "r"),
    image_story:image_story,
    is_wide: story[:is_wide].present?,
    is_published: story_i+1 == stories.length,
    is_eurasianet_story: is_eurasianet_story
  )
  # I18n.locale = :ru
  # image_share = File.new("#{Rails.root}/public/_stories/share/#{I18n.locale}/#{image_id}.jpg", "r")
  # s.image_share = image_share
  # s.save
  if !s.valid?
    puts s.errors.inspect
  end

}

