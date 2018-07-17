class Modu < ApplicationRecord
  belongs_to :course
  has_many :comments
  has_many :completions
end
