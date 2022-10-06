class CommentsController < ApplicationController
  before_action :authenticate_account!
  before_action :find_comment, only: %i[destroy update]

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      @post = @comment.post
      respond_to do |format|
        format.js
      end
    else
      flash[:alert] = "Something went wrong ..."
    end
  end

  def update
    authorize @comment
    if @comment.update(comment_params)
      @post = @comment.post
      respond_to do |format|
        format.js
      end
    else
      flash[:alert] = "Something went wrong ..."
    end
  end

  def destroy
    authorize @comment
    @post = @comment.post

    @comment.destroy
    respond_to do |format|
      format.js
    end
  end

  private

  def find_comment
    @comment = Comment.find_by(id: params[:id])
    return if @comment

    flash[:alert] = "comment not exist!"
    redirect_to root_path
  end

  def comment_params
    params.required(:comment).permit :account_id, :post_id, :content, :parent_id
  end
end
