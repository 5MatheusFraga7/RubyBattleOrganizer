class DungeonMaster < ApplicationRecord
  
  belongs_to :user
  has_many   :battle_fields

  validates :user_id, presence: true 

end
