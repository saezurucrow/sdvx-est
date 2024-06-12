class AddColumnDeleteFlagFromSong < ActiveRecord::Migration[6.1]
  def change
    add_column :songs, :delete_flag, :integer, default: 0, null: false
  end
end
