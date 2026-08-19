class SubmissionsController < ApplicationController
  def index
    assignment = Assignment.find(params[:assignment_id])
    @submissions = policy_scope(assignment.submissions)
  end

  def create
    assignment = Assignment.find(params[:assignment_id])
    submission = assignment.submissions.build(
      submission_params.merge(student: current_user, submitted_at: Time.current)
    )
    authorize submission
    submission.save
    redirect_to assignment_submissions_path(assignment)
  end

  def update
    submission = Submission.find(params[:id])
    authorize submission, :grade?
    submission.update(grade: params[:grade], feedback: params[:feedback])
    redirect_back fallback_location: root_path, notice: "Grade Saved"
  end

  private

  def submission_params = params.require(:submission).permit(:content)
end
