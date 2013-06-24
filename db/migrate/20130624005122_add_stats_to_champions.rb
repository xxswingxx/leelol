class AddStatsToChampions < ActiveRecord::Migration
  def change
  	add_column :champions, :source_url, :string
  	add_column :champions, :health, :float
  	add_column :champions, :crit_chance, :string
  	add_column :champions, :mana, :float
  	add_column :champions, :health_regen, :float
  	add_column :champions, :speed, :float
  	add_column :champions, :mana_regen, :float
  	add_column :champions, :armor, :float 
  	add_column :champions, :range, :integer
  	add_column :champions, :magic_res, :float
  end
end
