class AccountsController < ApplicationController
  before_action :set_account , only: [:follow, :unfollow, :show ]

  def follow
    id = account_params[:id]
    Follow.create(follower_id: current_account.id, followee_id: id)
    respond_to do |format|
      format.js
    end
  end

  def unfollow
    id = account_params[:id]
    current_account.followed_users.where(follower_id: current_account.id, followee_id: id).destroy_all
    respond_to do |format|
      format.js
    end
  end

  def show
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
    @account = Account.find(params[:id])
  end

  def account_params
    params.permit(:id)
  end


end
