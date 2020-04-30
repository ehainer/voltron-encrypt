class CreateUserAnimals < ActiveRecord::Migration
  def change
    create_table :user_animals do |t|
      t.integer :user_id
      t.integer :animal_id

      t.timestamps null: false
    end
  end
end
