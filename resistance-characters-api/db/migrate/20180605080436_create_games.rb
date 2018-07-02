class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.string :name
      t.string :code
      t.integer :status, default: 0, null: false
      t.boolean :commander, default: false, null: false
      t.boolean :false_commander, default: false, null: false
      t.boolean :bodyguard, default: false, null: false
      t.boolean :blind_spy, default: false, null: false
      t.boolean :deep_cover, default: false, null: false
      t.references :host,
        null: false, foreign_key: {to_table: :players}, index: true

      t.timestamps
    end
  end
end
