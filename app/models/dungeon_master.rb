class DungeonMaster < ApplicationRecord
  
  belongs_to :user
  
  has_many   :battle_fields
  has_many   :players

  validates :user_id, presence: true 

end
