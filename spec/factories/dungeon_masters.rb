FactoryBot.define do
  factory :dungeon_master do
    name { Faker::TvShows::Simpsons.character }
    profile_picture_url { "" }
    user
  end
end
