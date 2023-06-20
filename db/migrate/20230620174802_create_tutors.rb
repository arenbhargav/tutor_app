class CreateTutors < ActiveRecord::Migration[7.0]
  def change
    create_table :tutors do |t|
      t.string :name
      t.string :username
      t.string :email
      t.string :password_digest
      t.integer :course_id

      t.timestamps
    end
    add_index :tutors, :course_id
  end
end
