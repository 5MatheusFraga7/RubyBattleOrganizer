class CreateBattleFields < ActiveRecord::Migration[5.0]
  def change
    create_table :battle_fields do |t|
      t.references :dungeon_master, foreign_key: true
      t.string :title
      t.string :background_url

      t.timestamps
    end
  end
end
