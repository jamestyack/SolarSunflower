# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) are set in the file config/application.yml.
# See http://railsapps.github.com/rails-environment-variables.html
puts 'ROLES'
YAML.load(ENV['ROLES']).each do |role|
  Role.find_or_create_by_name({ :name => role }, :without_protection => true)
  puts 'role: ' << role
end
puts 'DEFAULT USERS'
user = User.find_or_create_by_email :name => ENV['ADMIN_NAME'].dup, :email => ENV['ADMIN_EMAIL'].dup, :password => ENV['ADMIN_PASSWORD'].dup, :password_confirmation => ENV['ADMIN_PASSWORD'].dup
puts 'user: ' << user.name
user.add_role :admin


unless Site.find_by_name("Drexel URBN Center")
    site = Site.new :name => "Drexel URBN Center", :description => "This is a test site at the TechCamp hackathon", :address => "3501 Market Street", :zipcode => 19104

    site.save
end

unless CollectionPoint.find_by_name("Sunlight")
    site = Site.find_by_name("Drexel URBN Center")

    collection_point = site.collection_points.new :name => "Sunlight"

    collection_point.save
end

unless CollectionPoint.find_by_name("Moisture")
    site = Site.find_by_name("Drexel URBN Center")
    
    collection_point = site.collection_points.new :name => "Moisture"

    collection_point.save
end

3.times do

    collection_point = CollectionPoint.find_by_name("Sunlight")

    data_collection = collection_point.data_collections.new :collected_date => Time.now, :sunlight => 5, :temperature => 5

    data_collection.save
end

3.times do 

    collection_point = CollectionPoint.find_by_name("Moisture")

    data_collection = collection_point.data_collections.new :collected_date => Time.now, :soil_moisture_low => 5, :soil_moisture_medium => 5, :soil_moisture_high => 5

    data_collection.save
end
