class CommentsController < ApplicationController
  before_action :set_post

  def create  
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      flash[:success] = "¡Has comentado este post!"
      redirect_to :back
    else
    end
  end

  def destroy  
    @comment = @post.comments.find(params[:id])

    @comment.destroy
    flash[:success] = "Comentario eliminado :("
    redirect_to root_path
  end

  private

  def comment_params  
    params.require(:comment).permit(:content)
  end

  def set_post  
    @post = Post.find(params[:post_id])
  end
end