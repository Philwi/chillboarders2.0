# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
require 'open-uri'
module SeedHelper
  class << self
    def create_user
      params = { 'user' => { username: Faker::Name.name, password: 'hallo123', password_confirmation: 'hallo123', email: Faker::Internet.email}}
      result = User::Operation::Create.call(params: params)
      model = result['model']
      model.avatar.attach({
        io: SeedHelper.image_fetcher,
        filename: "faker_image.jpg"
      })
      model.update(country: Faker::Nation.nationality, city: Faker::Nation.capital_city, favourite_trick: 'Ollie', description: Faker::GreekPhilosophers.quote)
      puts 'User created'
      model
    end

    def create_spot(user)
      file = Rack::Test::UploadedFile.new("app/assets/images/sign_in_image.jpg", "image/jpeg")
      params = { 'spot' => {"title"=>Faker::Beer.brand, "description"=>Faker::Hipster.sentences.to_sentence,
        "type"=>Spot::Util::Helper::SPOT_TYPES.sample, "obstacles"=>Spot::Util::Helper::SPOT_OBSTACLES.sample(rand(10) + 1),
        "images"=>[file],
        "lat"=>Faker::Address.latitude.to_s, "lng"=>Faker::Address.longitude.to_s}}
      puts 'Spot created'
      result = Spot::Operation::Create.call(params: params, user: user)['model']
    end

    def edit_user_site(user_site, user)
      params = {
        "user_site"=>{"headline"=>Faker::Beer.brand, "text"=>Faker::Hipster.sentences, "primary_color"=>Faker::Color.hex_color,
        "secondary_color"=>Faker::Color.hex_color, "tertiary_color"=>Faker::Color.hex_color,
        "embedded_music_player_html"=>"<iframe style=\"border: 0; width: 100%;
        height: 42px;\"
        src=\"https://bandcamp.com/EmbeddedPlayer/album=3957281011/size=small/bgcol=ffffff/linkcol=0687f5/transparent=true/\"
        seamless><a
        href=\"http://schlimmband.bandcamp.com/album/heute-schlimmer-als-gestern\">HEUTE
        SCHLIMMER ALS GESTERN by SCHLIMM</a></iframe>"
      }}

      puts 'UserSite updated'
      result = UserSite::Operation::Update.call(params: params, user: user)
    end

    def create_user_messages
      for_user, from_user = User.all.sample(2)
      message = Faker::Hipster.sentences.join
      UserMessage.create(user: from_user, for_user_id: for_user.id, body: message)
    end

    def image_fetcher
      open("https://robohash.org/sitsequiquia.png?size=300x300&set=set1")
    end
  end
end

100.times do
  user = SeedHelper.create_user
  spot = SeedHelper.create_spot(user)
  SeedHelper.edit_user_site(user.user_site, user)
  SeedHelper.create_user_messages
end