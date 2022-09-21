class DropColumn < ActiveRecord::Migration[7.0]
  def change
    remove_column :courses, :creator_id, :integer
    remove_column :courses, :creator, :string
  end
end
