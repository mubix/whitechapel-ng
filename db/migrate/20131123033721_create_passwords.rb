class CreatePasswords < ActiveRecord::Migration
  def change
    create_table :passwords do |t|
      t.string :cleartext

      t.timestamps
    end
  end
end
