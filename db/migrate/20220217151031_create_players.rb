class CreatePlayers < ActiveRecord::Migration[5.0]
  def change
    create_table :players do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.string :profile_picture_url
      t.references :dungeon_master, foreign_key: true

      t.timestamps
    end
  end
end
