class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :name
      t.string :varval
      t.string :vartype

      t.timestamps
    end
  end
end
