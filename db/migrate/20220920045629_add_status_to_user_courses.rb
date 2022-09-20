class AddStatusToUserCourses < ActiveRecord::Migration[7.0]
  def change
    add_column :user_courses, :status, :boolean, default: false
  end
end
