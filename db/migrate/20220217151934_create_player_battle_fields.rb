class CreatePlayerBattleFields < ActiveRecord::Migration[5.0]
  def change
    create_table :player_battle_fields do |t|
      t.references :battle_field, foreign_key: true
      t.references :player, foreign_key: true

      t.timestamps
    end
  end
end
