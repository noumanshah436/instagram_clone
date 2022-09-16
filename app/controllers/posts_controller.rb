class PostsController < ApplicationController
  before_action :authenticate_account!
  before_action :find_post, only: [:show, :destroy]

  def index
    @posts = Post.all.includes(:photos, :account, :likes).order("id desc")

    @post = Post.new
  end

  def create
    @post = current_account.posts.new(post_params)
    p params[:images]
    if @post.save
      if params[:images]
        array = params[:images].values   # convert hash into array of values
        array.each do |img|
          @post.photos.create(image: img)    # save each image
        end
      end

      redirect_to posts_path
      flash[:notice] = "Post Created"
    else
      flash[:alert] = "Something went wrong ..."
      redirect_to posts_path
    end
  end

  def show
    @likes = @post.likes.includes(:account)

    # @comment = Comment.new
    # @is_bookmarked = @post.is_bookmarked(current_user)
    # set_meta_tags title: "Photo by "+@post.user.name
  end

  def destroy
    print "post:"
    p @post
    if @post.account == current_account
      if @post.destroy
        flash[:notice] = "Post deleted!"
      else
        flash[:alert] = "Something went wrong ..."
      end
    else
      flash[:notice] = "You don't have permission to do that!"
    end
    redirect_to posts_path
  end

  private

  def find_post
    @post = Post.find_by id: params[:id]

    return if @post
    flash[:danger] = "Post not exist!"
    redirect_to root_path
  end

  def post_params
    # params.require(:post).permit!
    # params.require(:post).permit!
    params[:images].permit!
    params.require(:post).permit :content
    # params[:images].permit!
    # params.permit(images: {})
  end
end
