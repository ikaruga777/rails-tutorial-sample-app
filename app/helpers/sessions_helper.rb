# 永続的セッションを実現する
module SessionsHelper
  
  def log_in(user)
    session[:user_id] = user.id
  end

  # ログイン情報の削除
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def log_out
    forget(current_user) 
    session.delete(:user_id)
    @current_user = nil
  end

  # 永続クッキーに保存する
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token]= user.remember_token
  end

  # ログインユーザですか?
  def current_user?(user)
    user == current_user
  end

  # ログイン中のユーザを返す
  def current_user
    if (user_id = session[ :user_id ])
      @current_user ||= User.find_by(id: session[:user_id])
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(:remember,cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def logged_in?
    !current_user.nil?
  end

  # セッションに記憶していたURLにリダイレクトする
  # セッションに無かった場合は引数で渡されたパスにリダイレクトする
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # アクセスしようとしたURLをセッションに記憶させとく
  # redirect_back_orで取り出せる
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

end
