class CreatePasswordHashes < ActiveRecord::Migration
  def change
    create_table :password_hashes do |t|
      t.string :hash
      t.integer :type_id
      t.integer :status_id
      t.integer :password_id

      t.timestamps
    end
  end
end
