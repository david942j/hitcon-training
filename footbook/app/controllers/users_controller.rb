class UsersController < ApplicationController
  skip_before_action :auth, only: %i[sign_in]
  before_action :admin, only: :upload

  def sign_in
    return unless params[:account] && params[:password]
    account = params[:account].to_s
    password = params[:password].to_s
    return render_error if account.empty? || account.size > 32 || account.match(/\A[a-zA-Z0-9_\.]+\Z/).nil?
    return render_error if password.empty? || password.size > 60
    user = User.find_by_account(account)
    # sign up
    if user.nil?
      user = User.create({ account: account, password: password })
    else
      return render_error('Wrong password') unless user.authenticate(password)
    end
    session[:user_id] = user.id
    cookies[:flag] = {
      value: Figaro.env.flag_cookie,
      expire: 1.year.from_now
    } if current_user.admin?
    render_ok
  end

  def logout
    session.delete(:user_id)
    cookies.delete(:flag)
    redirect_to '/users/sign_in'
  end

  def profile
    user_id = params[:id].to_i
    @user = User.find_by_id(user_id)
    return redirect_to root_path if @user.nil?
    @liked = current_user.foots.pluck(:post_id).to_set
    @posts = @user.posts.common
    render template: 'main/index'
  end

  def settings
    return if params[:password].nil?
    password = params[:password].to_s
    render_error('Invalid password') unless password.size.between?(1, 60)
    current_user.password = password
    current_user.save
    render_ok
  end

  def upload
    filepath = params[:favicon][:image].tempfile.path rescue nil
    return render inline: 'image plz' if filepath.nil?
    # Too lazy to install gems..
    system('/home/footbook/footbook/bin/convert', '-resize', '128x128', filepath, '/home/footbook/footbook/app/assets/images/footbook.ico')
    redirect_back(fallback_location: root_path)
  end
end
