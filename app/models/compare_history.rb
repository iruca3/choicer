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
end
