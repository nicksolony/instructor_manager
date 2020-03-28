class CreateCourseGroups < ActiveRecord::Migration
  def change
    create_table :course_group do |t|
      t.string :name, unique: true
      t.integer :creator_id
    end
  end
end
