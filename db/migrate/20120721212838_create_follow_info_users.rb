class CreateFollowInfoUsers < ActiveRecord::Migration
  def up
    create_table :fi_users do |t|
      t.string   :email,                                 :default => "", :null => false
      t.string   :encrypted_password,     :limit => 128, :default => "", :null => false
      t.string   :access_token
      t.string   :access_token_secret
      t.timestamps
    end
  end

  def down
    drop_table :fi_users
  end
end
