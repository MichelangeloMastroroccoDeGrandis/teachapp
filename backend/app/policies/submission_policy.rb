class SubmissionPolicy < ApplicationPolicy
  def create?
    user.student?
  end

  def grade?
    user.instructor? && record.assignment.course.instructor_id == user.id
  end

  class Scope < Scope
    def resolve
      if user.instructor?
        scope.joints(assignment: :course).where(courses: { instructor_id: user.id })
      else
        scope.where(student: user)
      end
    end
  end
end
