# == Schema Information
#
# Table name: points
#
#  id             :integer          not null, primary key
#  user_id        :integer          not null
#  value          :integer          default(0), not null
#  photography_id :integer          not null
#  created_at     :datetime
#  updated_at     :datetime
#

class Point < ActiveRecord::Base
  belongs_to :user
  belongs_to :photography
end
