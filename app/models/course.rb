class Course < ActiveRecord::Base
  validates_presence_of :name, :course_group_id
  include Slugify::InstanceMethods
  extend Slugify::ClassMethods

  belongs_to :instructor
  belongs_to :course_group
  has_many :instructors, through: :instructor_courses


end
