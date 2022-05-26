# frozen_string_literal: true

class CreateSongs < ActiveRecord::Migration[6.1]
  def change
    create_table :songs do |t|
      t.string :name, null: false
      t.string :artist, null: false
      t.integer :version, null: false
      t.integer :level, null: false
      t.integer :difficult, null: false
      t.integer :max_ex_score, null: false, default: 0

      t.timestamps
    end
  end
end
