FactoryBot.define do
  factory :player do
    user { nil }
    name { "MyString" }
    profile_picture_url { "MyString" }
    dungeon_master { nil }
  end
end
