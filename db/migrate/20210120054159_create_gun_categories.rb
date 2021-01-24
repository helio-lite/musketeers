class CreateGunCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :gun_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
