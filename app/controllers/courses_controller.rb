class CoursesController < ApplicationController
  before_action :set_course, only: [ :show, :edit, :update, :destroy ]
  skip_before_action :authenticate_user!, only: [ :index, :show ]
  def index
    @courses = policy_scope(Course)
  end

  def show
    authorize @course
    @enrollment = current_user&.enrollments&.find_by(course: @course)
  end

  def new
    @course = current_user.courses.build
    authorize @course
  end

  def create
    @course = current_user.courses.build(course_params)
    authorize @course
    if @course.save
      redirect_to @course, notice: "Course created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @course
  end

  def update
    authorize @course
    if @course.update(course_params)
      redirect_to @course, notice: "Course updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @course
    @course.destroy
    redirect_to courses_path, notice: "Course deleted."
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:title, :description, :published, :price)
  end
end
