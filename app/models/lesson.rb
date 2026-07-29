class Lesson < ApplicationRecord
  belongs_to :course
  has_many :lesson_completions, dependent: :destroy

  validates :title, presence: true
  validates :position, presence: true, uniqueness: { scope: :course_id }
end
