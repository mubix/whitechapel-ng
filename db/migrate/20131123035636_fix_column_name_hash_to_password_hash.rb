class FixColumnNameHashToPasswordHash < ActiveRecord::Migration
  def change
  	rename_column :pwhash, :hash, :password_hash
  end
end
