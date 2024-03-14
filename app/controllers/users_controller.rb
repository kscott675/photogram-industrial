class UsersController < ApplicationController
  def show
    @user = User.find_by!(username: params.fetch(:username))
  end

  def liked
    @user = User.find_by!(username: params.fetch(:username))
  end

  def feed
    if current_user == nil
      continue
    else
      @user = current_user
    end
  end

  def followers
    @user = @user = User.find_by!(username: params.fetch(:username))
  end

  def following
    @user = @user = User.find_by!(username: params.fetch(:username))
  end
end
