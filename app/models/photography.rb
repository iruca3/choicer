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
  include Redis::Objects
  mount_uploader :image, ImageUploader
  belongs_to :user
  has_many :points
  has_many :photography_genres
  has_many :genres, through: :photography_genres

  sorted_set :rank, global: true

  def self.get_ranking
    photo = Photography.first
    return [] unless photo
    Photography.where( id: photo.rank.members.reverse.slice( 0, 20 ) )
  end

  def global_rank
    rank[ self.id ] = self.points.pluck( :value ).inject( :+ ) if rank.revrank( self.id ).nil?
    score = rank.score( self.id )
    more_score_num = rank.range_size( score + 1, Float::INFINITY )
    more_score_num + 1
  end

  def my_rank( user )
    photo_id_list = user.compare_list.to_a
    rank = 0
    photo_id_list.each do |pid|
      rank += 1
      if pid.to_i == self.id
        return rank
      end
    end
    rank
  end
end
