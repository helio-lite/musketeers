class CreateInformation < ActiveRecord::Migration[5.2]
  def change
    create_table :information do |t|
      t.integer :character_id
      t.integer :title_id
      t.text :introduction
      t.integer :height
      t.string :hobby
      t.string :favorite
      t.references :character, foreign_key: true

      t.timestamps
    end
  end
end
