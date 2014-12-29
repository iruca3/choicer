# == Schema Information
#
# Table name: system_configs
#
#  id                      :integer          not null, primary key
#  twitter_consumer_key    :string(255)
#  twitter_consumer_secret :string(255)
#  facebook_api_key        :string(255)
#  facebook_api_secret     :string(255)
#  created_at              :datetime
#  updated_at              :datetime
#

class SystemConfig < ActiveRecord::Base
end
