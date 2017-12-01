class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def create
    current_user.follow(@user)
    redirect_back(fallback_location: user_path(@user))
  end

  def destroy
    current_user.unfollow(@user)
    redirect_back(fallback_location: user_path(@user))
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
