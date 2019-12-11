class CreateMaps < ActiveRecord::Migration[6.0]
  def change
    create_table :maps do |t|
      t.string :location
      t.decimal :lat
      t.decimal :long
      t.decimal :radius
      t.boolean :widget

      t.timestamps
    end
  end
end
