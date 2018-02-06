class SessionsController < ApplicationController
  def new
  end

  def create 
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # ログイン後リダイレクト
      log_in user
      redirect_to user
    else
      # エラー
      flash.now[:danger] = "Invalid email/password combination"
      render 'new'
    end
  end

  def destory
  end

end
