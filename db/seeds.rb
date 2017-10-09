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
PageContent.find_or_create_by(name: 'about') do |pc|
    puts 'creating page content for about'
    pc.title = 'About Red Legacy'
    pc.content = '<p>...</p>'
end

# load page content records with placeholder text
# eurasianet about
PageContent.find_or_create_by(name: 'about_eurasianet') do |pc|
    puts 'creating page content for about eurasianet'
    pc.title = 'About EurasiaNet'
    pc.content = '<p>....</p>'
end


