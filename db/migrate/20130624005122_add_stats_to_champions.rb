class AddStatsToChampions < ActiveRecord::Migration
  def change
  	add_column :champions, :range, :integer
  end
end
