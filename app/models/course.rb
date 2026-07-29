class Course < ApplicationRecord
  belongs_to :instructor, class_name: "Users"

  has_many :lessons, -> { order(:position) }, dependent: :destroy
  has_many :enrollments, dependent: :destroy
  has_many :students, through: :enrollments, source: :student

  validates :title, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
end
