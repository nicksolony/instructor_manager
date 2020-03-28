class Instructor < ActiveRecord::Base
  validates_presence_of :name, :email, :password_digest
  has_secure_password
  include Slugify::InstanceMethods
  extend Slugify::ClassMethods

  has_many :courses
  has_many :course_groups, through: :courses

end
