class CommentsController < ApplicationController
  load_and_authorize_resource

  def create
    post = Post.find(params[:post_id])
    @comment = post.comments.new(author: current_user, **comment_params)
    if @comment.save
      flash[:notice] = 'Comment created succesfully!'
      redirect_to user_post_path(post.author, post)
    else
      flash[:alert] = 'Comment creation failed!'
      render :new, status: :unprocessable_entityS
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
