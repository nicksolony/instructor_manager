class CourseGroup < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
  include Slugify::InstanceMethods
  extend Slugify::ClassMethods

  has_many :courses
  has_many :instructors, through: :courses

end
