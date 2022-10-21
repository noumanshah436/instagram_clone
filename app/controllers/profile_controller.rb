class ProfileController < ApplicationController
  before_action :authenticate_account!
  before_action :set_account, only: %i[show]
  
  def show
    @is_friend = @account.friend?(current_account)
    @posts = @account.my_posts(@is_friend)
  end

  def index
    keyword = params[:keyword]
    @users = Account.search(keyword.strip)
    respond_to do |format|
      format.js
    end
  end

  private

  def set_account
    @account = Account.find_by(account_params)
    return if @account

    flash[:alert] = "Account not exist!"
    redirect_to profile_path(current_account)
  end

  def account_params
    params.permit(:id)
  end
end
