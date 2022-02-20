FactoryBot.define do
  factory :dungeon_master do
    user_id { User.first.id }
    name { Faker::TvShows::Simpsons.character }
    profile_picture_url { "" }
  end
end
