class MonsterBattleField < ApplicationRecord
  belongs_to :battle_field
  belongs_to :dm_monster
end
