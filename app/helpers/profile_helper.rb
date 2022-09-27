module ProfileHelper

  # check if the given account is followed by current account
  def following?(account)
    current_account&.followees&.include?(account)
  end

  # check if current_account is follwed by given account
  def followed_by?(account)
    return true if account == current_account

    account&.followees&.include?(current_account)
  end

  def dom_id_for_follower(follower)
    dom_id(follower)
  end

end

module DeviseHelper
  # A simple way to show error messages for the current devise resource. If you need
  # to customize this method, you can either overwrite it in your application helpers or
  # copy the views to your application.
  #
  # This method is intended to stay simple and it is unlikely that we are going to change
  # it to add more behavior or options.
  def devise_error_messages!
    return "" if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t("errors.messages.not_saved",
                      count: resource.errors.count,
                      resource: resource.class.model_name.human.downcase)

    html = <<-HTML
      <div class="alert bg-warning alert-styled-left">
          <button type="button" class="close" data-dismiss="alert"><span>×</span><span class="sr-only">Close</span></button>
          #{messages}
      </div>
    HTML

    html.html_safe
  end
end
