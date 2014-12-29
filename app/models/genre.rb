# == Schema Information
#
# Table name: genres
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

class Genre < ActiveRecord::Base
  has_many :photography_genres
  has_many :photography, through: :photography_genres
end
