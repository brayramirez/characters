class CreateParticipants < ActiveRecord::Migration[5.2]
  def change
    create_table :participants do |t|
      t.references :player, foreign_key: true
      t.references :game, foreign_key: true
      t.boolean :opposition, default: false
      t.integer :character

      t.timestamps
    end

    add_index :participants, [:player_id, :game_id], unique: true
  end
end
