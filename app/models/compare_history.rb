# == Schema Information
#
# Table name: compare_histories
#
#  id                      :integer          not null, primary key
#  user_id                 :integer          not null
#  photography1_id         :integer          not null
#  photography2_id         :integer          not null
#  selected_photography_id :integer          not null
#  created_at              :datetime
#  updated_at              :datetime
#

class CompareHistory < ActiveRecord::Base
  belongs_to :photography1, foreign_key: :photography1_id, class_name: 'Photography'
  belongs_to :photography2, foreign_key: :photography2_id, class_name: 'Photography'

  def self.get_new_history( user, num )
    compared_list = []
    compared_list = user.compare_list.to_a if user.compare_list
    CompareHistory.where( 'photography1_id IN (?) AND photography2_id IN (?)', compared_list, compared_list ).order( 'created_at DESC' ).pluck( :photography1_id, :photography2_id ).uniq[ 0, num ]
  end

  def self.get_choose_count( photo1_id, photo2_id, choose_id )
    self.where( 'photography1_id IN (?) AND photography2_id IN (?)', [ photo1_id, photo2_id ], [ photo1_id, photo2_id ] ).where( selected_photography_id: choose_id ).count
  end
end
