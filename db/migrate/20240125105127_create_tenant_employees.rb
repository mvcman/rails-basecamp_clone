class CreateTenantEmployees < ActiveRecord::Migration[7.1]
  def change
    create_table :tenant_employees do |t|
      t.references :tenant, null: false, foreign_key: true
      t.references :employee, null: false, foreign_key: true
      t.string :role, null: false, default: "employee"
      
      t.timestamps
    end
  end
end
