class PostsController < ApplicationController
  before_action :authenticate_account!
  before_action :find_post, only: %i[show destroy edit update]

  before_action :check_images, only: %i[create]

  def index
    @posts = Post.all_posts
    @post = Post.new
    @follow_requests = current_account.all_follow_requests
  end

  def create
    @post = current_account.posts.new(post_params)
    if @post.save
      save_images
      flash[:notice] = "Post Created"
    else
      flash[:alert] = "Something went wrong ..."
    end
    redirect_to posts_path
  end

  def show
    @likes = @post.likes.includes(:account)
  end

  def edit
    authorize @post
  end

  def update
    authorize @post
    if @post.update(post_params)
      save_images
      flash[:notice] = "Post Updated"
    else
      flash[:alert] = "Something went wrong ..."
    end
    redirect_to post_path(@post)
  end

  def destroy
    authorize @post  # we can access this passed object using record
    if @post.destroy
      flash[:notice] = "Post deleted!"
    else
      flash[:alert] = "Something went wrong ..."
    end
    redirect_to posts_path
  end

  private

  def check_images
    unless params.key?(:images)
      flash[:alert] = "Add atleast one image"
      redirect_to posts_path
    end
  end

  def save_images
    if params[:images]
      array = params[:images].values
      array.each do |img|
        @post.photos.create(image: img)
      end
    end
  end

  def find_post
    @post = Post.find_by(id: params[:id])
    return if @post

    flash[:alert] = "Post not exist!"
    redirect_to root_path
  end

  def post_params
    if params.key?(:images)
      params[:images].permit!
    end
    params.require(:post).permit(:content, :active)
  end
end
