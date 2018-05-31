class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token, :reset_token
  # DBの種類によってindexが大文字小文字区別するしないを考えなくて良いようにする
  before_save :downcase_email
  before_create :create_activation_digest
  #validatesはメソッド、特定のハッシュに対してプロパティを設定する。からコロンの位置が絶妙な感じになってる
  validates :name, presence: true, length: { maximum: 50 }
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  # 指定した文字列の暗号化
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end  
  # 新規にランダム文字列発行
  def User.new_token
    SecureRandom.urlsafe_base64
  end           
  
  # セッションの永続化のため、DBに登録
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # attributeで指定した認証を確認する。
  def authenticated?(attribute, token)
    digest = self.send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  # アカウントの有効化
  def activate
    update_columns( activated:    true,
                    activated_at:  Time.zone.now)
  end

  # アカウント有効化用の認証メールを送信する
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  # パスワード再設定の属性を設定する
  def create_reset_digest
    self.reset_token = User.new_token
    update_columns( reset_digest: User.digest(reset_token),
                    reset_sent_at: Time.zone.now)
  end
  
  # パスワード再設定の期限がきれていないよね？
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  private

  def downcase_email
    self.email.downcase!
  end

   # アカウントの有効化トークンとダイジェストを発行する
  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end


end
