# == Schema Information
#
# Table name: users
#
#  id                        :integer          not null, primary key
#  sns_id                    :string(255)
#  provider                  :string(255)
#  created_at                :datetime
#  updated_at                :datetime
#  oauth_access_token        :string(255)
#  oauth_access_token_secret :string(255)
#

require 'redis/objects'

class User < ActiveRecord::Base
  include Redis::Objects
  has_many :points

  list :compare_list

  def user_hash
    Digest::SHA1.hexdigest( 'choicer_' + self.id.to_s + '_' + self.provider + '_' + self.sns_id )
  end

end
