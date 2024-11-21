class CreateTeamSettings < ActiveRecord::Migration[7.1]
  def change
    create_table :team_settings do |t|
      t.references :tenant, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true
      t.text :date_format, default: "DD-MM-YYYY", null: false
      t.text :approver_called_as, default: "Approver", null: false
      t.text :employee_called_as, default: "Employee", null: false
      t.integer :working_hours, default: 5
      t.json :work_week, default: ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday"]
      t.text :teams_called_as, default: "Team", null: false
      t.boolean :all_unlimited_days, default: false, null: false
      t.boolean :all_auto_approve, default: false, null: false
      t.integer :fy_start_month, default: 1
      t.integer :fy_end_month, default: 12
      t.timestamps
    end
  end
end
