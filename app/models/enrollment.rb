class Enrollment < ApplicationRecord
  belongs_to :student, class_name: "User"
  belongs_to :course
  has_many :lesson_completions, dependent: :destroy

  validates :student_id, uniqueness: { scope: :course_id, message: "already enrolled in this course" }

  def recalculate_progress!
    total = course.lessons.count
    return update!(progress_percent: 0) if total.zero?

    done = lesson_completions.count
    update!(progress_percent: ((done.to_f / total) * 100).round)
  end
end
