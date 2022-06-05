class RenameExSocreToExScores < ActiveRecord::Migration[6.1]
  def change
    rename_column :ex_scores, :ex_socre, :ex_score
  end
end
