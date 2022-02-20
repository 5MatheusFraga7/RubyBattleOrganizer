class Player < ApplicationRecord

  validates :user, presence: true

  belongs_to :user
  belongs_to :dungeon_master

end
