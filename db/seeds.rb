# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

instructor = User.create!(name: "Alice Instructor", email: "alice@example.com", password: "password", role: :instructor)

students = 5.times.map do |i|
  User.create!(name: Faker::Name.name, email: "student#{i}@example.com", password: "password", role: :student)
end

course = Course.create!(title: "Intro to Rails", description: Faker::Lorem.paragraph, instructor: instructor, published: true, price: 49.0)

5.times do |i|
  course.lessons.create!(title: "Lesson #{i + 1}", content: Faker::Lorem.paragraphs(number: 3).join("\n\n"), position: i + 1)
end

students.each do |student|
  enrollment = student.enrollments.create!(course: course, enrolled_at: Time.current)
  course.lessons.sample(rand(1..3)).each do |lesson|
    LessonCompletion.create!(enrollment: enrollment, lesson: lesson)
  end
  enrollment.recalculate_progress!
end

puts "Seeded #{User.count} users, #{Course.count} courses, #{Enrollment.count} enrollments."
