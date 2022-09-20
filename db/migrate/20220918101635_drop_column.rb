class DropColumn < ActiveRecord::Migration[7.0]
  def change
    remove_column :courses, :creator_id
    remove_column :courses, :creator
  end
end
