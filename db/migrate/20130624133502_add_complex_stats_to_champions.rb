class AddComplexStatsToChampions < ActiveRecord::Migration
  def change
    add_column :champions, :health_base, :float 
    add_column :champions, :health_per_lvl, :float 
    add_column :champions, :health_regen_base, :float
    add_column :champions, :health_regen_per_lvl, :float
    add_column :champions, :mana_base, :float 
    add_column :champions, :mana_per_lvl, :float 
    add_column :champions, :mana_regen_base, :float 
    add_column :champions, :mana_regen_per_lvl, :float
    add_column :champions, :attack_base, :float 
    add_column :champions, :attack_per_lvl, :float 
    add_column :champions, :attack_speed_base, :float
    add_column :champions, :attack_speed_per_lvl, :float
    add_column :champions, :armor_base, :float 
    add_column :champions, :armor_per_lvl, :float 
    add_column :champions, :magic_resist_base, :float
    add_column :champions, :magic_resist_per_level, :float
    add_column :champions, :movement_speed, :float
  end
end
