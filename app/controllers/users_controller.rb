class UsersController < ApplicationController
  def new
    #newアクションで使うUserをここで定義する。
    @user = User.new
  end
  def show
    @user = User.find(params[:id])
  end
end
