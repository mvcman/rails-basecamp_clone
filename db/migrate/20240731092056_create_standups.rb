class CreateStandups < ActiveRecord::Migration[7.1]
  def change
    create_table :standups do |t|
      t.references :user, null: false, foreign_key: true
      t.references :template, null: false, foreign_key: true

      t.timestamps
    end
  end
end
