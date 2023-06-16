class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  def update_comments_conuter
    post.increment!(:comments_cuonter)
  after_create :update_comments_counter

  private

  def update_comments_counter
    post.increment!(:comments_counter)
  end
end