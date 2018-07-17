class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum role: [:student, :teacher, :admin]

  validates :name, presence: true
  validates :role, presence: true

  has_many :courses
  has_many :enrollments
  has_many :enrolled_courses, through: :enrollments, source: :course
  has_many :comments
  has_many :completions

  def all_courses
    enrolled_courses.union(courses)
  end

  def complete?(modu)
    return Completion.where(modu: modu, user: self).size > 0
  end
end
