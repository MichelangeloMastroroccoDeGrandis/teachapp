class LessonCompletion < ApplicationRecord
  belongs_to :enrollment
  belongs_to :lesson
end
