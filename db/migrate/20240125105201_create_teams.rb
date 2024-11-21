class CreateTeams < ActiveRecord::Migration[7.1]
  def change
    create_table :teams do |t|
      t.string :name
      t.text :description
      t.references :tenant, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :channel_id
      t.string :channel_name
      t.boolean :is_bot_added
      t.json :auto_approved_leave_type
      t.text :channel_service_url

      t.timestamps
    end
    rename_column :teams, :user_id, :created_by
  end
end
