class CreateOauthTables < ActiveRecord::Migration[4.2]
  def self.up
    create_table :client_applications do |t|
      t.string :name
      t.string :url
      t.string :support_url
      t.string :callback_url
      t.string :key, :limit => 65
      t.string :secret, :limit => 65
      t.integer :user_id

      t.timestamps
    end
    add_index :client_applications, :key, :unique => true

    create_table :oauth_tokens do |t|
      t.integer :user_id
      t.string :type, :limit => 20
      t.integer :client_application_id
      t.string :token, :limit => 65
      t.string :secret, :limit => 65
      t.string :callback_url
      t.string :verifier, :limit => 20
      t.string :scope
      t.timestamp :authorized_at, :invalidated_at, :expires_at
      t.timestamps
    end

    add_index :oauth_tokens, :token, :unique => true

    create_table :oauth_nonces do |t|
      t.string :nonce
      t.integer :timestamp

      t.timestamps
    end
    add_index :oauth_nonces,[:nonce, :timestamp], :unique => true

  end

  def self.down
    drop_table :client_applications
    drop_table :oauth_tokens
    drop_table :oauth_nonces
  end

end
