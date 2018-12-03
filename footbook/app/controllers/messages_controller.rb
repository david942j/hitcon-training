class MessagesController < ApplicationController
  def send_message
    account = params[:account].to_s
    content = params[:content].to_s
    return render_error('Invalid content') if content.empty? || content.size >= 1024
    to = User.find_by_account(account)
    return render_error('User not exists') if to.nil?
    Message.create(user_id: to.id, from_user_id: current_user.id, content: content)
    render_ok
  end

  def show
    @messages = current_user.messages
      .select(:content, :from_user_id)
      .includes(:user)
      .limit(10)
      .order(id: :desc)
  end
end
