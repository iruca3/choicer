# == Schema Information
#
# Table name: photographies
#
#  id         :integer          not null, primary key
#  image      :string(255)      not null
#  user_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Photography < ActiveRecord::Base
end
