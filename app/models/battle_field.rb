class BattleField < ApplicationRecord
  
  belongs_to :dungeon_master
  validates  :dungeon_master_id, :title, presence: true 

end
