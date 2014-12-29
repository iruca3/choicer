class PhotographiesController < ApplicationController

  def create
    @photo = Photography.new( photography_params )
    @photo.user_id = current_user.id
    @photo.save
  end

  def judge_form
    judged_photography_ids = current_user.points.pluck( :photography_id )
    photography_ids = Photography.where.not( id: judged_photography_ids ).pluck( :id )
    @photography = Photography.where( id: photography_ids.shuffle.first ).first
    unless @photography
      render text: '点数をつけていない写真がありません。' and return
    end
    session[:photography_id] = @photography.id
  end

  def judge
    render 'judge_form' and return unless session[:photography_id]
    @photography = Photography.where( id: session[:photography_id] ).first
    render 'judge_form' and return unless @photography
    @point = Point.new( user_id: current_user.id, photography_id: @photography.id, value: params[:point] )
    begin
      @point.save
    rescue
      render 'judge_form'
      return
    end
  end

  private
  def photography_params
    params.require( :photography ).permit(
      :image, :remote_image_url
    )
  end

end
