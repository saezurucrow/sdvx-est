class CreateExScores < ActiveRecord::Migration[6.1]
  def change
    create_table :ex_scores do |t|
      t.integer :user_id, null: false
      t.integer :song_id, null: false
      t.integer :ex_socre, null: false, default: 0
      t.integer :play_count, null: false, default: 0

      t.timestamps
    end
  end
end
