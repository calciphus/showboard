class CreateInteractions < ActiveRecord::Migration
  def change
    create_table :interactions do |t|
      t.string :ds_id
      t.text :content
      t.string :author_id
      t.string :author_name
      t.boolean :has_photo
      t.string :source_type
      t.boolean :body_match
      t.boolean :link_match

      t.timestamps
    end
  end
end
