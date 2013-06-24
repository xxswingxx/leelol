class AddActiveToItems < ActiveRecord::Migration
  def change
  	add_column :items, :active, :text
  end
end
