# frozen_string_literal: true

class DeleteUserIdCoulumnsFromExScoreDifference < ActiveRecord::Migration[6.1]
  def change
    remove_column :ex_score_differences, :user_id, :integer
  end
end
