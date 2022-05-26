class RemoveSkillLevelFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :skill_level, :integer
  end
end
