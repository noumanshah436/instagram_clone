module PostsHelper
  def show(post)
    ( post.active? || current_account == post.account  ) || followed_by?(post.account)
  end
end
