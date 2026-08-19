# JSON for the instructor dashboard (InstructorDashboard.jsx).
# The controller requires a signed-in instructor (authenticate_user! +
# a role check), so this only renders for the right user. Mirrors the data
# used by instructor/show.html.erb.
json.total_students @total_students
json.courses @courses do |course|
  json.id             course.id
  json.title          course.title
  json.published      course.published
  json.students_count course.enrollments.size
end
