class ChangesongIdToExScoreDifference < ActiveRecord::Migration[6.1]
  def change
    rename_column :ex_score_differences, :song_id, :ex_score_id
  end
end
