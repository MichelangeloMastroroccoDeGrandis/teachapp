class Submission < ApplicationRecord
  belongs_to :student
  belongs_to :course
  belongs_to :instructor
end
