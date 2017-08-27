class ChangePassColumn < ActiveRecord::Migration
  def change
	  rename_column :users, :encrypted_password, :password
  end
end
