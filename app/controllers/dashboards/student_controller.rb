module Dashboards
  class StudentController < ApplicationController
    before_action -> { redirect_to root_path unless current_user.student? }

    def show
      @enrollements = current_user.enrollments.includes(:course)
    end
  end
end
