class LikesController < ApplicationController
  before_action :authenticate_account!
  before_action :find_like, only: %i[destroy]

  def create
    @like = current_account.likes.new(like_params)
    @post = @like.post
    if @like.save!
      respond_to do |format|
        format.js
      end
    else
      flash[:alert] = "Something went wrong ..."
    end
  end

  def destroy
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

  def find_like
    @like = Like.find_by(id: params[:id])

    return if @like

    redirect_to root_path
  end

  def like_params
    params.permit :post_id
  end
end
