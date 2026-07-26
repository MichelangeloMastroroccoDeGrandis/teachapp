class Course < ApplicationRecord
  belongs_to :instructor

  has_many :lessons
  has_many :enrollments
  has_many :students, through: :enrollments
end
