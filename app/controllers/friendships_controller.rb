class FriendshipsController < ApplicationController
  def create
    want_to_follow = User.find(params[:id])
    current_user.friendships.build(friend_id: want_to_follow.id)
    if current_user.save
      flash[:notice] ="Following #{want_to_follow.full_name}"
    else
      flash[:alert] = "There was a problem"
    end
    redirect_to my_friends_path
  end

  def destroy
    friendship_to_kill = User.find(params[:id])
    Friendship.where(user_id: current_user.id, friend_id: friendship_to_kill.id).first.destroy
    flash[:notice] ="Successfully unfollowed #{friendship_to_kill.full_name}"
    redirect_to my_friends_path
  end
end
