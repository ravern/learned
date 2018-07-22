class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum role: [:student, :teacher, :admin]

  validates :name, presence: true
  validates :role, presence: true

  has_many :courses, dependent: :delete_all
  has_many :enrollments, dependent: :delete_all
  has_many :enrolled_courses, through: :enrollments, source: :course
  has_many :comments, dependent: :delete_all
  has_many :completions, dependent: :delete_all

  def all_courses
    enrolled_courses.union(courses)
  end

  def discover_courses
    Course.where(public: true).where.not(id: all_courses.map(&:id))
  end

  def complete?(course_or_modu)
    if course_or_modu.is_a? Modu
      return Completion.where(modu: course_or_modu, user: self).size > 0
    end

    if course_or_modu.modus.empty?
      return false
    end

    course_or_modu.modus.each do |modu|
      unless complete? modu
        return false
      end
    end
    return true
  end
end
