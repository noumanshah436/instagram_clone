class FollowsController < ApplicationController
  before_action :authenticate_account!
  before_action :set_account, only: %i[create destroy]

  def create
    if current_account.follow(@account)
      respond_to do |format|
        format.js
      end
    else
      flash[:alert] = "Something went wrong ..."
    end
  end

  def destroy
    if current_account.unfollow(@account)
      respond_to do |format|
        format.js
      end
    else
      flash[:alert] = "Something went wrong ..."
    end
  end

  private

  def set_account
    @account = Account.find_by(follow_params)
    return if @account

    flash[:alert] = "Account not exist!"
    redirect_to profile_path(current_account)
  end

  def follow_params
    params.permit(:id)
  end
end
