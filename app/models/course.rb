class Course < ActiveRecord::Base
  validates_presence_of :name, :course_group_id
  validates_uniqueness_of :name
  include Slugify::InstanceMethods
  extend Slugify::ClassMethods

  belongs_to :course_group
  has_many :instructors, through: :instructor_courses
  has_many :instructor_courses


end
