FactoryBot.define do
  factory :player do
    user 
    name { Faker::JapaneseMedia::OnePiece.character }
    profile_picture_url { "-------------" }
    dungeon_master
  end
end
