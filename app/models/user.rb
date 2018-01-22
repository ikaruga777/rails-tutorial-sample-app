class User < ApplicationRecord
  #validatesはメソッド、特定のハッシュに対してプロパティを設定する。からコロンの位置が絶妙な感じになってる
  validates :name, presence: true
  validates :email, presence: true
end
