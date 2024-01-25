class CreateTenantSettings < ActiveRecord::Migration[7.1]
  def change
    create_table :tenant_settings do |t|
      t.string :date_format

      t.timestamps
    end
  end
end
