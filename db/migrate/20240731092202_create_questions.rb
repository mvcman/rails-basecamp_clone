class CreateQuestions < ActiveRecord::Migration[7.1]
  def change
    create_table :questions do |t|
      t.references :template, null: false, foreign_key: true
      t.text :question, null: false
      t.string :question_type, null: false
      t.text :options

      t.timestamps
    end
  end
end
