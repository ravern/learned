class Modu < ApplicationRecord
  belongs_to :course
  has_many :comments
  has_many :completions

  validates :title, presence: true
  validates :content, presence: true
end
