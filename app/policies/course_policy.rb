class CoursePolicy < ApplicationPolicy
  # NOTE: Up to Pundit v2.3.1, the inheritance was declared as
  # `Scope < Scope` rather than `Scope < ApplicationPolicy::Scope`.
  # In most cases the behavior will be identical, but if updating existing
  # code, beware of possible changes to the ancestors:
  # https://gist.github.com/Burgestrand/4b4bc22f31c8a95c425fc0e30d7ef1f5

  def index? = true
  def show? = record.published? || owner?
  def create? = user.instructor?
  def update? = owner?
  def destroy? = owner?

  private

  def owner?
    user.instructor? && record.instructor_id == user.id
  end

  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  class Scope < Scope
    def resolve
      user.instructor? ? scope.where(instructor: user) : scope.where(published: true)
    end
  end
end
