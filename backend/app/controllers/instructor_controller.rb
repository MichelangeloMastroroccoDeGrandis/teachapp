module Dashboard
  class InstructorController < ApplicationController
    def show
      authorize :instructor_dashboard, :show?
      @courses = current_user.courses
    end
  end
end