class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses do |t|
      t.string :language
      t.string :creator
      t.string :name
      t.timestamps
    end
  end
end
