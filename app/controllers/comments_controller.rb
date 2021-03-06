class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id
    @post_id = @comment.post_id
    @parent_comment_id = @comment.parent_comment_id

    if @comment.save
      redirect_to post_url(@comment.post_id)
    else
      # fail if @comment.post_id.nil?
      flash[:errors] = @comment.errors.full_messages
      render :new
    end
  end

  def new
    @comment = Comment.new
    @post_id = params[:post_id]

    render :new
  end

  def show
    @comment = Comment.find(params[:id])

    render :show
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :author_id, :post_id, :parent_comment_id)
  end
end
