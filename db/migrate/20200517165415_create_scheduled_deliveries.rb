class CreateScheduledDeliveries < ActiveRecord::Migration[6.0]
  def change
    create_table :scheduled_deliveries do |t|
      t.datetime :scheduled_for
      t.string :service_provider
      t.references :shopping_list, null: false, foreign_key: true

      t.timestamps
    end
  end
end
