class PhotographiesController < ApplicationController

  def create
    @photo = Photography.new( photography_params )
    @photo.user_id = current_user.id
    @photo.save
  end

  private
  def photography_params
    params.require( :photography ).permit(
      :image, :remote_image_url
    )
  end

end
