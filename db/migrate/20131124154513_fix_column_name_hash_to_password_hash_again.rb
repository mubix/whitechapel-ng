class FixColumnNameHashToPasswordHashAgain < ActiveRecord::Migration
  def change
      rename_column :pwhashes, :hash, :password_hash
  end
end
