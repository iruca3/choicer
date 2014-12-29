# == Schema Information
#
# Table name: photography_genres
#
#  id             :integer          not null, primary key
#  genre_id       :integer          not null
#  photography_id :integer          not null
#  created_at     :datetime
#  updated_at     :datetime
#

class PhotographyGenre < ActiveRecord::Base
end
