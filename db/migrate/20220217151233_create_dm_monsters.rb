class CreateDmMonsters < ActiveRecord::Migration[5.0]
  def change
    create_table :dm_monsters do |t|
      t.references :dungeon_master, foreign_key: true
      t.string :name
      t.string :profile_picture_url
      t.integer :health_points

      t.timestamps
    end
  end
end
