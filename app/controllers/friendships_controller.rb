class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])
    @friend = User.find(params[:friend_id])
    if @friendship.save
      Notification.create(recipient: @friend, actor: current_user, action: "added")
      flash[:notice] = "Friend requested."
      redirect_to :back
    else
      flash[:error] = "Unable to request friendship."
      redirect_to :back
    end
  end

  def update
  @friendship = Friendship.find(params[:id])
  @friendship.accepted = true
    if @friendship.save
      if @friendship.friend != current_user
        Notification.create(recipient: @friendship.friend, actor: current_user, action: "added")
      else
        Notification.create(recipient: @friendship.user, actor: current_user, action: "added")
      end
      redirect_to network_path, notice: "Successfully confirmed friend!"
    else
      redirect_to network_path, notice: "Could not confirm friend."
    end
  end

  def destroy
    @friendship = Friendship.find_by(id: params[:id])
    @friendship.destroy
    flash[:notice] = "Friendship undone."
    redirect_to :back
  end
end
