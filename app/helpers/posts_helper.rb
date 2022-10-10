module PostsHelper
  def check_redirection_to_posts_path
    expect(response).to redirect_to posts_path
  end

  def check_redirection_to_post(postt)
    expect(response).to redirect_to post_path(postt)
  end
end
