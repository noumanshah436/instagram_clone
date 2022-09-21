class StoriesController < ApplicationController
  before_action :authenticate_account!

  def index
    # @posts = Post.all.includes(:photos, :account, :likes).order("id desc")
    @story = Story.new
  end

  def new
  end

  def create
  end


  def show
  end

  def destroy
  end
end
