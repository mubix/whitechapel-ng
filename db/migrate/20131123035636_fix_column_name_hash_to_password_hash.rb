class FixColumnNameHashToPasswordHash < ActiveRecord::Migration
  def change
  	rename_column :Password_hashes, :hash, :password_hash
  end
end
