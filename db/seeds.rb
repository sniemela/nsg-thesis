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

categories = %w(Festival Conference Movie Concert Expo Party Nightlife)
Category.create(categories.map { |c| {:name => c} })

tags = %w(Computers Music Metal Trance Programming Cars)
Tag.create(tags.map { |t| {:name => t} })

client_type_names = %w(Company Organization Institute)
client_types = ClientType.create(client_type_names.map { |ct| { :name => ct } })

clients_info = [{
  :name => 'Kino City (Vaasa)',
  :description => 'Cinema',
  :client_type_id => client_types[0].id
}]

clients = Client.create(clients_info)

events = [{
  :name => 'Hangover Part II',
  :description => 'Hangover movie',
  :start_time => Time.now + 1.day,
  :end_time => Time.now + 1.week,
  :active_time_start => Time.now - 5.days,
  :active_time_end => Time.now + 1.week,
  :city => 'Vaasa',
  :address => 'Hovioikeudenpuistikko 16',
  :country => 'Finland',
  :submitter_id => clients[0].id,
  :submitter_type => 'Client'
},
{
  :name => 'The Rise of The Planet Of The Apes',
  :description => 'Ape movie',
  :start_time => Time.now + 2.days,
  :end_time => Time.now + 2.days + 2.hours,
  :active_time_start => Time.now - 4.days,
  :active_time_end => Time.now + 2.weeks,
  :city => 'Vaasa',
  :address => 'Hovioikeudenpuistikko 16',
  :country => 'Finland',
  :submitter_id => clients[0].id,
  :submitter_type => 'Client'
}]

Event.create(events)
