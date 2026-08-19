# JSON for a single course, consumed by the React course page (CoursePage.jsx).
# CoursesController#show already sets @course and @enrollment, and skips auth for
# published courses, so a guest can read this. Requesting /courses/:id.json makes
# Rails render this template instead of show.html.erb.
json.id          @course.id
json.title       @course.title
json.description @course.description
json.price       @course.price
json.published   @course.published
json.instructor  @course.instructor.name

json.lessons @course.lessons do |lesson|
  json.id       lesson.id
  json.title    lesson.title
  json.position lesson.position
end

# Progress only exists for a signed-in student who has enrolled in this course.
if @enrollment
  json.enrolled true
  json.progress_percent @enrollment.progress_percent
else
  json.enrolled false
end
