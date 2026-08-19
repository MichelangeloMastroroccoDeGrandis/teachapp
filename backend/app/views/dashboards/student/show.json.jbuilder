# JSON for the student dashboard (StudentDashboard.jsx).
# Requires a signed-in student. Mirrors student/show.html.erb.
# Note: reads @enrollments, which the controller sets (see the typo fix in
# student_controller.rb — it previously assigned the misspelled @enrollements).
json.enrollments @enrollments do |enrollment|
  json.course_id        enrollment.course.id
  json.course_title     enrollment.course.title
  json.progress_percent enrollment.progress_percent
end
