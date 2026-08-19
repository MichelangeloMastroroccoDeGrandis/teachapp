# JSON representation of the course list, consumed by the React frontend.
#
# Why this file is all that's needed: CoursesController#index already assigns
# @courses (= policy_scope(Course), i.e. published courses for a guest). When a
# request asks for the JSON format (GET /courses.json), Rails looks for a template
# named index.json.* and renders THIS file instead of index.html.erb. No change to
# the controller or routes is required.
#
# jbuilder builds a JSON structure with a small Ruby DSL: `json.foo value` adds a
# "foo" key; `json.array!(collection) { |item| ... }` builds a JSON array.
json.array! @courses do |course|
  json.id            course.id
  json.title         course.title
  json.description   course.description
  json.price         course.price
  json.published     course.published
  json.thumbnail_url course.thumbnail_url
  json.instructor    course.instructor.name
  json.lessons_count course.lessons.size
end
