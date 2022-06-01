# frozen_string_literal: true

class CreateSongs < ActiveRecord::Migration[6.1]
  def change
    create_table :songs do |t|
      t.string :name, null: false, default: '-'
      t.string :artist, null: false, default: '-'
      t.integer :version, null: false, default: 0
      t.integer :level, null: false, default: 0
      t.integer :difficult, null: false, default: 0
      t.integer :max_ex_score, null: false, default: 0

      t.timestamps
    end
  end
end
