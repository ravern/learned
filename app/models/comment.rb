class Comment < ApplicationRecord
  belongs_to :modu
  belongs_to :user

  validates :content, presence: true
end
