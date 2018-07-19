class Course < ApplicationRecord
  belongs_to :user
  has_many :modus
  has_many :enrollments
  has_many :students, through: :enrollments, source: :user

  validates :title, presence: true
  validates :description, presence: true

  validate :verify_student_emails

  def student?(user)
    return students.where(id: user.id).size > 0
  end

  def student_emails
    return students.map { |student| student.email }.join(', ')
  end

  def student_emails=(emails)
    emails = emails.split(',').map { |email| email.strip }.uniq
    students = []

    emails.each do |email|
      student = User.find_by(email: email)
      unless student
        @student_emails_invalid = true
        return
      end
      if student == user.email
        @student_emails_invalid = true
        return
      end
      students << student
    end

    unless @student_emails_invalid
      enrollments.destroy_all
      students.each do |student|
        Enrollment.create!(user: student, course: self)
      end
    end
  end

  def verify_student_emails
    if @student_emails_invalid
      errors.add(:students, "invalid email provided")
    end
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
