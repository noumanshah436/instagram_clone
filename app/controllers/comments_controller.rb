class CommentsController < ApplicationController
  before_action :authenticate_account!

  def index
    @comments = @post.comments.includes(:account)
  end

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
    @comment = Comment.find(params[:id])

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
    @comment = Comment.find(params[:id])
    @post = @comment.post
    if @comment.destroy
      respond_to do |format|
        format.js
      end
    else
      flash[:alert] = "Something went wrong ..."
    end
  end

  private
  def comment_params
    params.required(:comment).permit :account_id, :post_id, :content, :parent_id
  end
end