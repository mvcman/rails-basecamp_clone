class CreateTenants < ActiveRecord::Migration[7.1]
  def change
    create_table :tenants do |t|
      t.string :name
      t.references :employee, null: false, foreign_key: true
      t.uuid :workspace_id, null: true
      t.string :sign_in_by, default: "email"

      t.timestamps
    end
    rename_column :tenants, :employee_id, :created_by
  end
end
