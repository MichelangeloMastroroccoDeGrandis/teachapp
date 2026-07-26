class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: { student: 0, instructor: 1 }
  has_many :courses, foreign_key: :instructor_id, dependent: :destroy
  has_many :enrolled_courses, through: :enrollments, source: :course

  validates :name, presence: true

  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.role ||= :student
  end
end
