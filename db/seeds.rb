# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts 'Beginning Seeding of Database'

 newuser = User.create!(email: 'admin@something.com', password: 'something', password_confirmation: 'something')
# #
# # puts 'Creating Default Test Messages'
 k = SignupKey.create!(key: 'restlog2015', isvalid: true, active: true, key_type: SignupKey::KEY_TYPES[:multiple])


#
u = User.first
u.update_attributes(:account_key => 'Restlogkey')
 a = App.create! user: u, name: 'test1', app_token: 'token1', monitor: true


 m1 = MessageLevel.create!(name: 'Fatal', code: 'fatal', level: 5)
 m2 = MessageLevel.create!(name: 'Error',code: 'error', level: 4)
 m3 = MessageLevel.create!(name: 'Warning', code: 'warning',level: 3)
 m4 = MessageLevel.create!(name: 'Debug', code: 'debug',level: 2)
 m5 = MessageLevel.create!(name: 'Info', code: 'info',level: 1)
 m6 = MessageLevel.create!(name: 'Misc', code: 'misc',level: 0)
# #
 apps = App.user_apps(u)

longJson = %Q{
 {
  "apptype": "ios",
  "application": "Cannon Run",
  "messageKey": "level6",
  "build": "4.3.10",
  "platform": "ps4",
  "platformDetails": {
    "os": "iOS 8.1",
    "device": "iPhone 6 Plus"
  },
  "gamedata": {
    "player": {
      "level": "6"
    },
    "level": {},
    "totalTime": "23.85.19",
    "totalDeaths": "8",
    "secrets": {
      "shrineWall": "true",
      "brokenNecklace": "false",
      "axeOfTheGods": "true"
    },
    "mostKilledBy": "fallingTree"
  }
}
}

#
apps.each do |item|

  times = rand(10..50)
(0..times).each do |i|
  msg1 = Message.create!(
  level: i%4,
  app: item,
  event_data: JSON.parse(longJson)
  )
end

end
