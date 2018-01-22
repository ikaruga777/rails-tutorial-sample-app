class User < ApplicationRecord
  #validatesはメソッド、特定のハッシュに対してプロパティを設定する。からコロンの位置が絶妙な感じになってる
  validates :name, presence: true, length: { maximum: 50}
  validates :email, presence: true, length: { maximum: 255 }
end
