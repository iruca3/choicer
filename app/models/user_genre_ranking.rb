# == Schema Information
#
# Table name: user_genre_rankings
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  genre_id   :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class UserGenreRanking < ActiveRecord::Base
end
