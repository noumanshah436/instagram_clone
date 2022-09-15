class LikesController < ApplicationController
  before_action :authenticate_account!

  def create
    @like = current_account.likes.new(like_params)
    @post = @like.post
    if @like.save
      respond_to do |format|
        format.js
      end
    else
      flash[:alert] = "Something went wrong ..."
    end
  end

  def destroy
    @like = Like.find(params[:id])
    @post = @like.post
    if @like.destroy
      respond_to do |format|
        format.js
      end
    else
      flash[:alert] = "Something went wrong ..."
    end
  end

  private
  def like_params
    params.permit :post_id
  end
end
