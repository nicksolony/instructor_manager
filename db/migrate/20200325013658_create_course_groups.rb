class CreateCourseGroups < ActiveRecord::Migration
  def change
    create_table :course_groups do |t|
      t.string :name, unique: true
      t.integer :creator_id
    end
  end
end
