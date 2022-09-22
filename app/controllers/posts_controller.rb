class PostsController < ApplicationController
  before_action :authenticate_account!
  before_action :find_post, only: [:show, :destroy, :edit, :update]

  def index
    @posts = Post.get_posts
    @post = Post.new
    @follow_requests = current_account.get_all_follow_requests
  end

  def create
    if !params.has_key?(:images)
      flash[:alert] = "Add atleast one image"
      redirect_to posts_path
    else
      @post = current_account.posts.new(post_params)
      # p params[:images]
      if @post.save
        if params[:images]
          array = params[:images].values   # convert hash into array of values
          array.each do |img|
            @post.photos.create(image: img)    # save each image
          end
        end
        flash[:notice] = "Post Created"
      else
        flash[:alert] = "Something went wrong ..."

      end
      redirect_to posts_path
    end
  end

  def show
    @likes = @post.likes.includes(:account)
  end

  def edit
    # we have @post from callback
    if !(@post.is_belongs_to? current_account)     # if become true if is_belongs_to return nil
      redirect_to posts_path
      flash[:notice] = "You are not authorized to do this action!"
    end
  end

  def update
    if @post.update(post_params)
      if params[:images]
        array = params[:images].values   # convert hash into array of values
        array.each do |img|
          @post.photos.create(image: img)    # save each image
        end
        puts "Image Added"
      end
      redirect_to posts_path
      flash[:notice] = "Post Updated"
    else
      flash[:alert] = "Something went wrong ..."
      redirect_to post_path(@post)
    end
  end

  def destroy
    if @post.account == current_account
      # remove also from cloudinary
      @post.photos.each do |photo|
        puts "delete photo #{photo.id}"
        DeleteImageJob.perform_later( photo[:image])
      end

      if @post.destroy
        flash[:notice] = "Post deleted!"
      else
        flash[:alert] = "Something went wrong ..."
      end
    else
      flash[:alert] = "You don't have permission to do that!"
    end
    redirect_to posts_path
  end

  private

  def find_post
    @post = Post.find_by( id: params[:id])

    return if @post
    flash[:alert] = "Post not exist!"
    redirect_to root_path
  end

  def post_params
    # params.require(:post).permit!
    # params.require(:post).permit!
    if params.has_key?(:images)
      params[:images].permit!
    end
    params.require(:post).permit( :content, :active)
    # params[:images].permit!
    # params.permit(images: {})
  end
end
