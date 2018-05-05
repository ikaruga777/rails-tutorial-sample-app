class AccountActivationsController < ApplicationController
  
  # 認証URLからのユーザ有効化
  def edit
    user = User.find_by(email: params[:email])
    # 有効化は一度のみ可能にする
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = "Account activated!"
      redirect_to user
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end
end
