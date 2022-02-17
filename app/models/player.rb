class Player < ApplicationRecord
  belongs_to :user
  belongs_to :dungeon_master
end
