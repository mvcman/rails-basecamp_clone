class CreateHolidays < ActiveRecord::Migration[7.1]
  def change
    create_table :holidays do |t|
      t.belongs_to :tenant, null: false, foreign_key: true
      t.text :name, null: false
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
