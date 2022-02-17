class CreateDungeonMasters < ActiveRecord::Migration[5.0]
  def change
    create_table :dungeon_masters do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.string :profile_picture_url

      t.timestamps
    end
  end
end
