class AddSuperuserIdToCourses < ActiveRecord::Migration[7.0]
  def change
    add_column :courses, :superuser_id, :integer
  end
end
