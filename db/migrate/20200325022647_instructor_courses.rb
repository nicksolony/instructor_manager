class InstructorCourses < ActiveRecord::Migration
  def change
    create_table :instructor_courses do |t|
      t.integer :instructor_id
      t.integer :course_id
    end
  end
end
