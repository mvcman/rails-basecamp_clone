class CreateTeamEmployees < ActiveRecord::Migration[7.1]
  def change
    create_table :team_employees do |t|
      t.references :team, null: false, foreign_key: true
      t.references :tenant, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :role, null: false, default: "employee"

      t.timestamps
    end
  end
end
