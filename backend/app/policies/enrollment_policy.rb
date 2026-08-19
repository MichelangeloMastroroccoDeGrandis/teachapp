class EnrollmentPolicy < ApplicationPolicy
  def create?
    user.student?
  end

  def destroy?
    user.student? && record.student_id == user.id
  end

  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
