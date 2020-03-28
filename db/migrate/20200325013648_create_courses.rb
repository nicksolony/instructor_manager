class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name, unique: true
      t.integer :course_length
      t.string :course_description
      t.integer :creator_id
      t.integer :course_group_id
    end
  end
end
