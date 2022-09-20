class RemoveStatusFromUserCourses < ActiveRecord::Migration[7.0]
  def change
    remove_column :user_courses, :status, :string
  end
end
