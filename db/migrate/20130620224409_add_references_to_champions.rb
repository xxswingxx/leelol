class AddReferencesToChampions < ActiveRecord::Migration
  def change
  	add_column :champions, :user_id, :reference
  end
end
