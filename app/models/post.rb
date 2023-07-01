class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def recent_five_comments
    comments.last(5)
  end

  after_destroy :decrement_post_counter

  private

  def update_post_counter
    author.increment!(:post_counter)
  end


  def decrement_post_counter
    author.decrement!(:post_counter)
  end
end
