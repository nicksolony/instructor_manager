class Instructor < ActiveRecord::Base
  validates_presence_of :name, :email, :password_digest
  validates_uniqueness_of :name, :email
  
  has_secure_password
  include Slugify::InstanceMethods
  extend Slugify::ClassMethods

  has_many :courses
  has_many :course_groups, through: :courses

end
