class CreateUserCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :user_courses do |t|
      t.references :user, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true
      t.string :status, default: :inprogress
      t.timestamps
    end
  end
end
