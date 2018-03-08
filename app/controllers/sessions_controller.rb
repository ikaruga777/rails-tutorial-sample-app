class SessionsController < ApplicationController
  def new
  end

  def create 
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      # ログイン後リダイレクト
      log_in @user
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      redirect_to @user
    else
      # エラー
      flash.now[:danger] = "Invalid email/password combination"
      render 'new'
    end
  end

  def destroy
    # 二重削除はエラーになるのでログイン判別する
    log_out if logged_in?
    redirect_to root_url
  end

end
