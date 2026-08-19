class EnrollmentsController < ApplicationController
  def create
    course = Course.find(params[:course_id])
    enrollment = current_user.enrollments.build(course: course, enrolled_at: Time.current)
    authorize enrollment
    if enrollment.save
      redirect_to course, notice: "Enrolled!"
    else
      redirect_to course, alert: enrollment.errors.full_messages.to_sentence
    end
  end

  def destroy
    enrollment = current_user.enrollments.find_by!(course_id: params[:course_id])
    authorize enrollment
    enrollment.destroy
    redirect_to course_path, notice: "Unenrolled"
  end
end
