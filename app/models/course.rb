class Course < ApplicationRecord
  belongs_to :user
  has_many :modus
  has_many :enrollments
  has_many :students, through: :enrollments, source: :user

  def student?(user)
    return students.where(id: user.id).size > 0
  end

  # Returns number of students who have completed the course.
  def completion_count
    count = 0

    students.each do |student|
      if student.complete?(self)
        count += 1
      end
    end

    return count
  end
end
