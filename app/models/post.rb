class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  def author_name
    user.full_name
  end
end
