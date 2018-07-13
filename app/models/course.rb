class Course < ApplicationRecord
  belongs_to :user
  has_many :modus
  has_many :enrollments
  has_many :students, through: :enrollments, source: :user
end
