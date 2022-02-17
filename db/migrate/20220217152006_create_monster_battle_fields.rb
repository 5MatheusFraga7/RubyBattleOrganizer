class CreateMonsterBattleFields < ActiveRecord::Migration[5.0]
  def change
    create_table :monster_battle_fields do |t|
      t.references :battle_field, foreign_key: true
      t.references :dm_monster, foreign_key: true

      t.timestamps
    end
  end
end
