class AddHistoryCountToUser < ActiveRecord::Migration
  def change
    add_column :users, :history_count, :integer,default: 0
  end
end
