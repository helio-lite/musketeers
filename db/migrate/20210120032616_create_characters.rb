class CreateCharacters < ActiveRecord::Migration[5.2]
  def change
    create_table :characters do |t|
      t.string :name_ja
      t.string :name_en
      t.string :name_gun
      t.integer :gun_category_id
      t.integer :gun_type_id
      t.integer :country_id
      t.text :motif

      t.timestamps
    end
    add_index :characters, :name_ja, unique: true
    add_index :characters, :name_en, unique: true
    add_index :characters, :name_gun, unique: true
  end
end
