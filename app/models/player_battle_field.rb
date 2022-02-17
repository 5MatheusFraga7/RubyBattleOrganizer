class PlayerBattleField < ApplicationRecord
  belongs_to :battle_field
  belongs_to :player
end
