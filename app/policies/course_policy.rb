class CoursePolicy < ApplicationPolicy
  def index? = true
  def show? = record.published? || owner?
  def create? = user&.instructor?
  def update? = owner?
  def destroy? = owner?

  private

  def owner?
    user&.instructor? && record.instructor_id == user.id
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      user&.instructor? ? scope.where(instructor: user) : scope.where(published: true)
    end
  end
end
