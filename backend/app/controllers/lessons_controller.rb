class LessonsController < ApplicationController
  before_action :set_course
  before_action :set_lesson, only: [ :show, :edit, :update, :destroy, :complete ]

  def show
    # @enrollment = current_user&.enrollments&.find_by(course: @course)
    authorize @lesson
  end

  def new
    @lesson = @course.lessons.build
    # authorize @course, :update?
    authorize @lesson.becomes(Lesson).tap { _1.course = @course }, :create?
  end

  def create
    @lesson = @course.lessons.build(lesson_params)
    # authorize @course, :update?
    authorize @lesson

    # if @lesson.save
    #  redirect_to course_lesson_path(@course, @lesson), notice: "Lesson created."
    # else
    #  render :new, status: :unprocessable_entity
    # end
    @lesson.save
    redirect_to course_lesson_path(@course, @lesson)
  end

  def edit
    authorize @lesson
  end

  def update
    authorize @lesson
    @lesson.update(lesson_params)
    redirect_to course_lesson_path(@course, @lesson)
  end

  def destroy
    authorize @lesson
    @lesson.destroy
    redirect_to @course
  end

  def complete
    authorize @lesson, :complete?
    enrollment = current_user.enrollments.find_by!(course: @course)
    LessonCompletion.find_or_create_by(enrollment: enrollment, lesson: @lesson) do |lc|
      lc.completed_at = Time.current
    end
    enrollment.recalculate_progress!
    redirect_to course_lesson_path(@course, @lesson), notice: "Lesson marked complete"
  end

  private

  def set_course
    @course = Course.find(params[:course_id])
  end

  def set_lesson
    @lesson = @course.lessons.find(params[:id])
  end

  def lesson_params
    params.require(:lesson).permit(:title, :context, :video_url, :position)
  end
end
