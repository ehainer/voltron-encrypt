class CreateUserCars < ActiveRecord::Migration
  def change
    create_table :user_cars do |t|
      t.integer :user_id
      t.integer :car_id

      t.timestamps null: false
    end
  end
end
