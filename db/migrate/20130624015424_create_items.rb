class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.text :passive
      t.integer :cost

      t.timestamps
    end
  end
end
