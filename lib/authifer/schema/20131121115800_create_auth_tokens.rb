class CreateAuthTokens < ActiveRecord::Migration
  def change
    add_column :users, :auth_tokens, :text

    add_index :users, :email, unique: true
  end
end
