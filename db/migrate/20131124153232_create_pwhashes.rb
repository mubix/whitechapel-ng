class CreatePwhashes < ActiveRecord::Migration
  def change
    create_table :pwhashes do |t|
      t.string :pwhash
      t.integer :type_id
      t.integer :status_id
      t.integer :password_id

      t.timestamps
    end
  end
end