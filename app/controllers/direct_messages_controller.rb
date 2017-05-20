class DirectMessagesController < ApplicationController
  before_action :authenticate_user!

  def show
    @other_user = User.find(params[:id])
    users = [current_user, @other_user]
    @chatroom = Chatroom.direct_message_for_users(users)
    @messages = @chatroom.messages.order(created_at: :desc).limit(100).reverse
    @chatroom_user = current_user.chatroom_users.find_by(chatroom_id: @chatroom.id)
    render "direct_messages/show"
  end
end
