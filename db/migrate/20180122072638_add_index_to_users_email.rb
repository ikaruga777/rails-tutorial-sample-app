class AddIndexToUsersEmail < ActiveRecord::Migration[5.1]
  def change
    # usersテーブルのemailカラムに一意制約を付けますよ
    add_index :users, :email, unique: true
  end
end
