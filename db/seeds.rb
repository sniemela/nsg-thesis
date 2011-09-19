# encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
begin
  require File.join(File.dirname(__FILE__), 'user_seeds')
rescue LoadError
  puts "Please copy and rename user_seeds.rb.bak to user_seeds.rb and write down your login information."
  raise
end

categories = [{
  :name => 'Festivals',
  :description => 'Latest festival information.'
},
{
  :name => 'Conferences',
  :description => 'Latest conference and convention information.'
},
{
  :name => 'Movies',
  :description => 'Latest movie times, trailers and reviews.'
},
{
  :name => 'Concerts',
  :description => 'Latest concert information and tour dates.'
},
{
  :name => 'Nightlife',
  :description => 'Latest nightlife and dating events.'
},
{
  :name => 'Sports',
  :description => 'Latest recreational and sporting events.'
},
{
  :name => 'Education',
  :description => 'Latest educational events, classes, adn workshops.'
}]

Category.create!(categories)

categorizations = [{
  :event_id => 1,
  :category_id => 3
},
{
  :event_id => 2,
  :category_id => 3
},
{
  :event_id => 3,
  :category_id => 6
}]

Categorization.create!(categorizations)

tags = %w(Computers Music Metal Trance Programming Cars)
Tag.create!(tags.map { |t| {:name => t} })

clients_info = [{
  :name => 'Kino City (Vaasa)',
  :description => 'Cinema',
  :client_type => Client::TYPE_COMPANY,
  :country => 'Finland',
  :address => 'Hovioikeudepuistikko 16',
  :confirmed => false,
  :user => User.first
}]

clients = Client.create!(clients_info, :without_protection => true)

events = [{
  :name => 'Hangover Part II',
  :description => 'Hangover movie',
  :active_time_start => Time.now - 5.days,
  :active_time_end => Time.now + 1.week,
  :city => 'Vaasa',
  :address => 'Hovioikeudenpuistikko 16',
  :country => 'Finland',
  :submitter_id => clients[0].id,
  :submitter_type => 'Client',
  :approved => true
},
{
  :name => 'The Rise of The Planet Of The Apes',
  :description => 'Ape movie',
  :active_time_start => Time.now - 4.days,
  :active_time_end => Time.now + 2.weeks,
  :city => 'Vaasa',
  :address => 'Hovioikeudenpuistikko 16',
  :country => 'Finland',
  :submitter_id => clients[0].id,
  :submitter_type => 'Client',
  :approved => false
},
{
  :name => 'Los Angeles Kings vs Anaheim Ducks',
  :description => 'Hockey game',
  :active_time_start => Time.now,
  :active_time_end => Time.now + 2.hours,
  :city => 'Los Angeles',
  :address => '1111 S. Figueroa Street',
  :country => 'USA',
  :submitter_id => clients[0].id,
  :submitter_type => 'Client',
  :approved => true
}]

Event.create!(events)

showtimes = [{
  :start_time => Time.now + 2.day,
  :end_time => Time.now + 2.week,
  :event_id => 1
},
{
  :start_time => Time.now + 1.day,
  :end_time => Time.now + 1.week,
  :event_id => 1
},
{
  :start_time => Time.now + 3.days,
  :end_time => Time.now + 3.days + 3.hours,
  :event_id => 2
},
{
  :start_time => Time.now + 4.days,
  :end_time => Time.now + 4.days + 4.hours,
  :event_id => 2
},
{
  :start_time => Time.now + 2.days,
  :end_time => Time.now + 2.days + 2.hours,
  :event_id => 2
}]

Showtime.create!(showtimes)
