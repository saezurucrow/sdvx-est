class CreateSettings < ActiveRecord::Migration[6.1]
  def change
    create_table :settings do |t|
      t.integer :opened, null: false, default: 0

      t.timestamps
    end
  end
end
