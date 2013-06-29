class RemoveAuthTokenFromUsers < ActiveRecord::Migration
  def change
  	remove_column :users, :auth_token
  end
end
