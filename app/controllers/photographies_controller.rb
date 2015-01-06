class PhotographiesController < ApplicationController

  def create
    # ローカル用
    redirect_to new_photography_path and return unless params['photography']
    # リモート用
    redirect_to new_photography_path and return if params['photography']['remote_image_url'] && photography_params['remote_image_url'].blank?
    @photo = Photography.new( photography_params )
    @photo.user_id = current_user.id
    @photo.save
  end

  def judge_form
    judged_photography_ids = current_user.points.pluck( :photography_id )
    photography_ids = Photography.where.not( id: judged_photography_ids ).pluck( :id )
    @photography = Photography.where( id: photography_ids.shuffle.first ).first
    unless @photography
      @info = '点数をつけていない写真がありません。'
      render '/message' and return
    end
    session[:photography_id] = @photography.id
  end

  def judge
    judge_form and render 'judge_form' and return unless session[:photography_id]
    @photography = Photography.where( id: session[:photography_id] ).first
    session[:photography_id] = nil
    judge_form and render 'judge_form' and return unless @photography
    @point = Point.new( user_id: current_user.id, photography_id: @photography.id, value: params[:point] )
    begin
      @point.save
      @info = '点数をつけました。'
      @return_to = '/photography/judge_form'
      render '/message' and return
    rescue
      judge_form and render 'judge_form'
      return
    end
  end

  def compare_form
    redirect_to root_url and return if Photography.count <= 1
    if current_user.compare_list.length <= 0
      target_new_photo_id = Photography.all.pluck( :id ).shuffle.first
      while 1
        compared_photo_id = Photography.all.pluck( :id ).shuffle.first
        break if compared_photo_id != target_new_photo_id
      end
    else
      target_new_photo_id = Photography.where.not( id: current_user.compare_list.to_a ).pluck( :id ).shuffle.first
      compared_photo_id = get_binary_search_user_photo[:photo_id]
      if target_new_photo_id == compared_photo_id || target_new_photo_id.nil?
        @info = '比較する写真がありません。'
        render '/message' and return
      end
    end
    @target_new_photo = Photography.where( id: target_new_photo_id ).first
    @compared_photo = Photography.where( id: compared_photo_id ).first

    session[:compare_info] = ''
    session[:target_photo_id] = @target_new_photo.id
    session[:compared_photo_id] = @compared_photo.id
  end

  def compare
    @target_new_photo = Photography.where( id: session[:target_photo_id] ).first
    @compared_photo = Photography.where( id: session[:compared_photo_id] ).first
    redirect_to root_path and return if @target_new_photo.nil? || @compared_photo.nil?

    @choiced_photo = @target_new_photo if params[:id].to_i == @target_new_photo.id
    @choiced_photo = @compared_photo if params[:id].to_i == @compared_photo.id
    redirect_to root_path and return if @choiced_photo.nil?

    if CompareHistory.where( user_id: current_user.id, photography1_id: @target_new_photo.id, photography2_id: @compared_photo.id ).count <= 0 && CompareHistory.where( user_id: current_user.id, photography1_id: @compared_photo.id, photography2_id: @target_new_photo.id ).count <= 0
      CompareHistory.create( user_id: current_user.id, photography1_id: @target_new_photo.id, photography2_id: @compared_photo.id, selected_photography_id: @choiced_photo.id )
    end

    if current_user.compare_list.length <= 0
      current_user.compare_list << @choiced_photo.id
      if @choiced_photo.id == @target_new_photo.id
        current_user.compare_list << @compared_photo.id
      else
        current_user.compare_list << @target_new_photo.id
      end
      compare_form() and render 'compare_form' and return

    else
      # 二分探索で決定します。
      compare_info = session[:compare_info]
      session[:compare_info] += ( @choiced_photo.id == @target_new_photo.id ? 'o' : 'x' )
      bin_search = get_binary_search_user_photo
      if bin_search[:finished]
        current_user.compare_list.insert( ( @choiced_photo.id == @target_new_photo.id ? 'before' : 'after' ), @compared_photo.id.to_s, @target_new_photo.id )
        session[:compare_info] = ''
        @info = '好みがより明確化しました。'
        @return_to = '/photography/compare_form'
        render '/message' and return
      else
        compared_photo_id = bin_search[:photo_id]
        @compared_photo = Photography.where( id: compared_photo_id ).first
        session[:compared_photo_id] = @compared_photo.id
        render 'compare_form' and return
      end
    end
  end

  private

  def get_binary_search_user_photo
    session[:compare_info] = [] unless session[:compare_info]
    compare_info = session[:compare_info]
    user_ranking = current_user.compare_list.to_a
    low_id = 0
    high_id = user_ranking.length - 1
    num = compare_info.length
    ( 0..compare_info.to_s.length - 1 ).each do |i|
      mid_id = ( ( low_id + high_id ) / 2 ).floor
      if compare_info[i,1] == 'o'
        high_id = mid_id - 1
      elsif compare_info[i,1] == 'x'
        low_id = mid_id + 1
      end
    end
    mid_id = ( ( low_id + high_id ) / 2 ).floor
    return { photo_id: user_ranking[ mid_id  ], finished: ( low_id > mid_id || high_id < mid_id ) }
  end

  def photography_params
    params.require( :photography ).permit(
      :image, :remote_image_url
    )
  end

end
