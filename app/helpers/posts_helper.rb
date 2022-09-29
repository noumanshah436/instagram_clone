module PostsHelper
   def show(post)
    return true 

    ( post.account.active? ||  is_friend?(post.account) ) || post.active?
   end
end
