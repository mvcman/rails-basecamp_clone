class CreateProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :profiles do |t|
      #General step
      t.string :first_name
      t.string :last_name
      t.integer :age
      t.string :email
      #Education step
      t.string :university
      t.string :level_of_education
      t.float :cgpa
      #Profession step
      t.string :job_title
      t.string :company

      t.references :user, null: false, foreign_key: true
      
      t.timestamps
    end
  end
end
