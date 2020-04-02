class Instructor < ActiveRecord::Base
  validates_presence_of :name, :email, :password_digest, :first_name, :last_name
  validates_uniqueness_of :name, :email

  has_secure_password
  include Slugify::InstanceMethods
  extend Slugify::ClassMethods

  has_many :course_groups
  has_many :course_groups, through: :courses
  has_many :courses, through: :instructor_courses
  has_many :instructor_courses

end
