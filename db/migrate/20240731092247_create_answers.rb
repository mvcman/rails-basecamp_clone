class CreateAnswers < ActiveRecord::Migration[7.1]
  def change
    create_table :answers do |t|
      t.references :standup, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.text :answer
      t.text :comment

      t.timestamps
    end
  end
end
