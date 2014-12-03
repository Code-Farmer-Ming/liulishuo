class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.text :desc
      t.integer :user_id

      t.timestamps
    end
  end
end
