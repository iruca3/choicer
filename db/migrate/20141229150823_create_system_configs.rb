class CreateSystemConfigs < ActiveRecord::Migration
  def change
    create_table :system_configs do |t|
      t.string        :twitter_consumer_key
      t.string        :twitter_consumer_secret
      t.string        :facebook_api_key
      t.string        :facebook_api_secret

      t.timestamps
    end
  end
end
