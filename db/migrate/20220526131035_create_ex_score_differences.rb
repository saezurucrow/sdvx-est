class CreateExScoreDifferences < ActiveRecord::Migration[6.1]
  def change
    create_table :ex_score_differences do |t|
      t.integer :user_id, null: false
      t.integer :song_id, null: false
      t.integer :upload_status_id, null: false
      t.integer :before_ex_score, null: false
      t.integer :after_ex_score, null: false

      t.timestamps
    end
  end
end
