class CreateVoltronUsers < ActiveRecord::Migration
  def change
    create_table :voltron_users do |t|
      t.string :email
      t.string :phone

      t.timestamps null: false
    end
  end
end
