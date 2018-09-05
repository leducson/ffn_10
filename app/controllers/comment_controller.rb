class CommentController < ApplicationController
  before_action :correct_user, :logged_in_user, only: :create

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      flash[:info] = t ".comment_success"
    else
      flash[:danger] = t ".comment_error"
    end
    redirect_to football_news_path(id: @comment.football_new_id)
  end

  private

  def comment_params
    params.require(:comment).permit :message, :user_id, :football_new_id
  end
end
