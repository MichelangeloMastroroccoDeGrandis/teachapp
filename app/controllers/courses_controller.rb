class CoursesController < ApplicationController
  before_action :set_course, only: [ :show, :edit, :update, :destroy ]
  skip_before_action :authenticate_user!, only: [ :index, :show ]
  def index
    @courses = policy_scope(Course)
  end

  def show
    authorize @course
    @enrollment = current_user&.enrollment&.find_by(course: @course)
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

  class LessonController < ApplicationController
    before_action :set_course
    before_action :set_lesson, only: [ :show, :edit, :update, :destroy, :complete ]

    def show; end

    def new
      @lesson = @course.lessons.build
      authorize @course, :update?
    end

    def create
      @lesson = @course.lessons.build(lesson_params)
      authorize @course, :update?
      @lesson.save
      redirect_to course_lesson_path(@course, @lesson)
    end

    def complete
      enrollment = current_user.enrollments.find_by!(course: @course)
      LessonCompletion.find_or_create_by(enrollment: enrollment, lesson: @lesson) do |lc|
        lc.completed_at = Time.current
      end
      enrollment.recalculate_progress!
      redirect_to course_lesson_path(@course, @lesson), notice: "Lesson marked complete"
    end

    private

    def set_course = @course = Course.find(params[:course_id])
    def set_lesson = @lesson = @course.lessons.find(params[:id])
    def lesson_params = params.require(:lesson).permit(:title, :content, :video_url, :position)
  end

  class EnrollmentsController < ApplicationController
    def create
      course = Course.find(params[:course_id])
      enrollment = current_user.enrollments.build(course: course, enrolled_at: Time.current)
      if enrollment.save
        redirect_to course, notice: "Enrolled!"
      else
        redirect_to course, alert: enrollment.errors.full_messages.to_sentence
      end
    end

    def destroy
      current_user.enrollments.find_by!(course_id: params[:course_id]).destroy
      redirect_to course_path, notice: "Unenrolled."
    end
  end
end
