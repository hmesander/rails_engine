class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :name
      t.text :description
      t.references :merchant, foreign_key: true
      t.bigint :unit_price

      t.timestamps
    end
  end
end
