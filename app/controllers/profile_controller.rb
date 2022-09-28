class ProfileController < ApplicationController
  before_action :authenticate_account!
  before_action :set_account, only: %i[follow unfollow show]

  def follow
    if current_account.follow(@account)
      respond_to do |format|
        format.js
      end
    else
      flash[:alert] = "Something went wrong ..."
    end
  end

  def unfollow
    current_account.unfollow(@account)
    respond_to do |format|
      format.js
    end
  end

  # profile page
  def show; end

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
