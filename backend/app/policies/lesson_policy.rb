class LessonPolicy < ApplicationPolicy
  def show?
    owner? || enrolled?
  end

  def create? = owner?
  def update? = owner?
  def destroy? = owner?
  def complete? = user.student? && enrolled?

  private

  def owner?
    user.instructor? && record.course.instructor_id == user.id
  end

  def enrolled?
    user.student? && record.course.enrollments.exists?(student: user)
  end

  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
