# frozen_string_literal: true

class CreateUploadStatuses < ActiveRecord::Migration[6.1]
  def change
    create_table :upload_statuses do |t|
      t.integer :user_id, null: false
      t.integer :upload_score_count, null: false, default: 0

      t.timestamps
    end
  end
end
