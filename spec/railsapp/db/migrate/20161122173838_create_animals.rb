class CreateAnimals < ActiveRecord::Migration[4.2]
  def change
    create_table :animals do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
