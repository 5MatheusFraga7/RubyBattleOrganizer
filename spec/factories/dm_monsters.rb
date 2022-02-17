FactoryBot.define do
  factory :dm_monster do
    dungeon_master { nil }
    name { "MyString" }
    profile_picture_url { "MyString" }
    health_points { 1 }
  end
end
