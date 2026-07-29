module Dashboards
  class InstructorController < ApplicationController
    before_action -> { redirect_to root_path unless current_user.instructor? }

    def show
      @courses = current_user.courses.includes(:enrollments)
      @total_students = Enrollment.where(course: @courses).distinct.count(:student_id)
    end
  end
end
