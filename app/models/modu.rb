class Modu < ApplicationRecord
  belongs_to :course
  has_many :comments, dependent: :delete_all
  has_many :completions, dependent: :delete_all

  validates :title, presence: true
  validates :content, presence: true
end
