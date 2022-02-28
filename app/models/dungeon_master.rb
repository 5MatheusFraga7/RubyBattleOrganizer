class DungeonMaster < ApplicationRecord
  
  belongs_to :user
  
  has_many   :players
  has_many   :dm_monsters

  has_many   :battle_fields
  has_many   :monster_battle_fields

  validates :user_id, presence: true 

end
