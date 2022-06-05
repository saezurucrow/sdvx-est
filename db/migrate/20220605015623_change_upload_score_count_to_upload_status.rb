class ChangeUploadScoreCountToUploadStatus < ActiveRecord::Migration[6.1]
  def change
    change_column_null(:upload_statuses, :upload_score_count, true)
  end
end
