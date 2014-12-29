class AddColumnOauthToUsers < ActiveRecord::Migration
  def change
    add_column :users, :oauth_access_token, :string
    add_column :users, :oauth_access_token_secret, :string
  end
end
