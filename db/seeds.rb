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
  :description => 'Latest festival information.',
  :image => File.open(Rails.root.join('app/assets/images/categories/festival.jpg'))
},
{
  :name => 'Conferences',
  :description => 'Latest conference and convention information.',
  :image => File.open(Rails.root.join('app/assets/images/categories/conference.jpg'))
},
{
  :name => 'Movies',
  :description => 'Latest movie times, trailers and reviews.',
  :image => File.open(Rails.root.join('app/assets/images/categories/movie.JPG'))
},
{
  :name => 'Concerts',
  :description => 'Latest concert information and tour dates.',
  :image => File.open(Rails.root.join('app/assets/images/categories/concert.jpg'))
},
{
  :name => 'Nightlife',
  :description => 'Latest nightlife and dating events.',
  :image => File.open(Rails.root.join('app/assets/images/categories/nightlife.jpg'))
},
{
  :name => 'Sports',
  :description => 'Latest recreational and sporting events.',
  :image => File.open(Rails.root.join('app/assets/images/categories/sport.jpg'))
},
{
  :name => 'Education',
  :description => 'Latest educational events, classes, and workshops.',
  :image => File.open(Rails.root.join('app/assets/images/categories/education.jpg'))
}]

categories = Category.create!(categories)

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
  :description => "Two years after the bachelor party in Las Vegas, Phil, Stu, Alan, and Doug jet to Thailand for Stu's wedding. Stu's plan for a subdued pre-wedding brunch, however, goes seriously awry.",
  :active_time_start => Time.now + 5.days,
  :active_time_end => Time.now + 2.weeks,
  :address => 'Hovioikeudenpuistikko 16, Vaasa',
  :city => 'Vaasa',
  :country => 'Finland',
  :submitter_id => clients[0].id,
  :submitter_type => 'Client',
  :approved => true,
  :picture => File.open(Rails.root.join('app/assets/images/events/hangover2.jpg'))
},
{
  :name => 'The Rise of The Planet Of The Apes',
  :description => "During experiments to find a cure for Alzheimer's disease, a genetically-enhanced chimpanzee uses its greater intelligence to lead other apes to freedom.",
  :active_time_start => Time.now + 4.days,
  :active_time_end => Time.now + 2.weeks,
  :address => 'Hovioikeudenpuistikko 16, Vaasa',
  :city => 'Vaasa',
  :country => 'Finland',
  :submitter_id => clients[0].id,
  :submitter_type => 'Client',
  :approved => true,
  :picture => File.open(Rails.root.join('app/assets/images/events/rotpota.jpg'))
},
{
  :name => 'Motörhead',
  :description => "Motörhead Suomessa! Varaa lippusi heti! Lipun hinta 50 euroa.",
  :active_time_start => Time.now + 4.days,
  :active_time_end => Time.now + 2.weeks,
  :address => 'Tallberginkatu 1 C 15, Helsinki',
  :city => 'Helsinki',
  :country => 'Finland',
  :submitter_id => clients[0].id,
  :submitter_type => 'Client',
  :approved => true,
  :picture => File.open(Rails.root.join('app/assets/images/events/motorhead.jpg'))
},
{
  :name => 'Educa Helsinki',
  :description => "Educa has earned its place as Finland's largest and most important annual training event for professionals in the education field. Educa is a forum where professionals actively look for new products and services and information to support their purchasing decisions.",
  :active_time_start => Time.now + 7.days,
  :active_time_end => Time.now + 8.weeks,
  :address => 'Messuaukio 1, Helsinki',
  :city => 'Helsinki',
  :country => 'Finland',
  :submitter_id => clients[0].id,
  :submitter_type => 'Client',
  :approved => true,
  :picture => File.open(Rails.root.join('app/assets/images/events/education.png'))
},
{
  :name => 'Provinssirock',
  :description => 'Ihmisten Juhla, Provinssirock, tuo Suomen kesään niin kansainväliset kuin kotimaisetkin kärkinimet, musiikkimaailman uudempia tuttavuuksia ja sykäyttävän tunnelman. Festivaalia on järjestetty jo vuodesta 1979 kulttuurihistoriallisella Törnävänsaaren puistoalueella.',
  :active_time_start => Time.now + 2.days,
  :active_time_end => Time.now + 2.weeks,
  :address => 'Vaasantie 11, Seinäjoki',
  :city => 'Seinäjoki',
  :country => 'Finland',
  :submitter_id => clients[0].id,
  :submitter_type => 'Client',
  :approved => false,
  :picture => File.open(Rails.root.join('app/assets/images/events/provinssi.png'))
},
{
  :name => 'Helsinki Motor Show',
  :description => 'The most awaited and biggest event displaying the best of automobile sector is all set for November. Luxury cars, vehicles, motorcycles, scooters, mopeds and all the other vehicles will be a part of this trade event. Suppliers, manufactures, sellers and others associated with the automobile industry will be seen under one roof at Helsinki Motor Show.',
  :active_time_start => Time.now + 2.days,
  :active_time_end => Time.now + 2.weeks,
  :address => 'Messuaukio 1, Helsinki',
  :city => 'Helsinki',
  :country => 'Finland',
  :submitter_id => clients[0].id,
  :submitter_type => 'Client',
  :approved => true,
  :picture => File.open(Rails.root.join('app/assets/images/events/motorshow.jpeg'))
},
{
  :name => 'HIFK - TPS',
  :description => 'SM-liiga ottelu HIFK - TPS Helsingin jäähallissa',
  :active_time_start => Time.now + 2.days,
  :active_time_end => Time.now + 2.days + 3.hours,
  :address => 'Vaasantie 11, Seinäjoki',
  :city => 'Seinäjoki',
  :country => 'Finland',
  :submitter_id => clients[0].id,
  :submitter_type => 'Client',
  :approved => true,
  :picture => File.open(Rails.root.join('app/assets/images/events/smliiga.jpg'))
},
{
  :name => "Club Silk - Valentine's Day Party Premiere at Helsinki Club (Sokos Hotel Helsinki)",
  :description => "Payment required - 8 euros - free entrance with The Queen of Hearts ticket
Pure Party Pleasure. Biggest Club Hits, Dance, RnB. Party so smooth it's got to be Silk... The Queen of Hearts official after party Club Silk will take over Helsinki Club right after the Queen has been crowned!",
  :active_time_start => Time.now + 3.days,
  :active_time_end => Time.now + 3.weeks,
  :address => 'Yliopistonkatu 8, Helsinki',
  :city => 'Helsinki',
  :country => 'Finland',
  :submitter_id => clients[0].id,
  :submitter_type => 'Client',
  :approved => true,
  :picture => File.open(Rails.root.join('app/assets/images/events/clubsilk.jpeg'))
},
{
  :name => "Viiniexpo 2012",
  :description => "Trade Days for Wines and Spirits, Wine Lover's Day Official Website ",
  :active_time_start => Time.now + 3.days,
  :active_time_end => Time.now + 3.weeks,
  :address => 'Messuaukio 1, Helsinki',
  :city => 'Helsinki',
  :country => 'Finland',
  :submitter_id => clients[0].id,
  :submitter_type => 'Client',
  :approved => true,
  :picture => File.open(Rails.root.join('app/assets/images/events/wine.jpg'))
},
{
  :name => "Vesa-Matti Loiri - Sydämeeni joulun teen",
  :description => "Veskun joulukonsertti Verkatehtaalla",
  :active_time_start => Time.now + 3.days,
  :active_time_end => Time.now + 3.weeks,
  :address => 'Hämeenlinna',
  :city => 'Hämeenlinna',
  :country => 'Finland',
  :submitter_id => clients[0].id,
  :submitter_type => 'Client',
  :approved => true,
  :picture => File.open(Rails.root.join('app/assets/images/events/vesku.jpg'))
}]

events = Event.create!(events)

event = events[0]
event.categories << categories[2]
event.save!

event = events[1]
event.categories << categories[2]
event.save!

event = events[2]
event.categories << categories[3]
event.save!

event = events[3]
event.categories << categories[6]
event.save!

event = events[4]
event.categories << categories[5]
event.save!

event = events[5]
event.categories << categories[1]
event.save!

event = events[6]
event.categories << categories[5]
event.save!

event = events[7]
event.categories << categories[3]
event.categories << categories[4]
event.save!

event = events[8]
event.categories << categories[0]
event.save!

event = events[9]
event.categories << categories[3]
event.save!

showtimes = [{
  :start_time => Time.now + 2.days,
  :end_time => Time.now + 2.weeks,
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
},
{
  :start_time => Time.now + 2.days,
  :end_time => Time.now + 2.days + 2.hours,
  :event_id => 3
},
{
  :start_time => Time.now + 2.days,
  :end_time => Time.now + 8.days + 2.hours,
  :event_id => 4
},
{
  :start_time => Time.now + 2.days,
  :end_time => Time.now + 8.days + 2.hours,
  :event_id => 5
},
{
  :start_time => Time.now + 2.days,
  :end_time => Time.now + 8.days + 2.hours,
  :event_id => 6
},
{
  :start_time => Time.now + 2.days,
  :end_time => Time.now + 2.days + 2.hours,
  :event_id => 7
},
{
  :start_time => Time.now + 2.days,
  :end_time => Time.now + 8.days + 2.hours,
  :event_id => 8
},
{
  :start_time => Time.now + 2.days,
  :end_time => Time.now + 8.days + 2.hours,
  :event_id => 9
},
{
  :start_time => Time.now + 2.days,
  :end_time => Time.now + 8.days + 2.hours,
  :event_id => 10
}]

Showtime.create!(showtimes)
