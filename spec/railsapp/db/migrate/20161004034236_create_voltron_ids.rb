class CreateVoltronIds < ActiveRecord::Migration[4.2]
  def change
    create_table :voltron_ids, id: false do |t|
      t.integer :id, limit: 8, primary_key: true
      t.integer :resource_id, limit: 8
      t.string :resource_type
    end
  end
end
