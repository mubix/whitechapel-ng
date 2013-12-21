class Addsourcetopasswords < ActiveRecord::Migration
  def change
    add_column :passwords, :source, :string
  end
end
