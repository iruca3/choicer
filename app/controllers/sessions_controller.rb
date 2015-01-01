class SessionsController < ApplicationController

  def setup
    @config = SystemConfig.first
    if params[:provider] == 'twitter'
      request.env['omniauth.strategy'].options[:consumer_key] = @config.twitter_consumer_key
      request.env['omniauth.strategy'].options[:consumer_secret] = @config.twitter_consumer_secret
    elsif params[:provider] == 'facebook'
      request.env['omniauth.strategy'].options[:client_id] = @config.facebook_api_key
      request.env['omniauth.strategy'].options[:client_secret] = @config.facebook_api_secret
    end
    render :text => "Omniauth setup phase.", :status => 404
  end

  def create
    uid = auth_hash[:uid]
    raise 'Invalid user ID.' if uid.blank?

    oat = auth_hash[:credentials][:token]
    oats = auth_hash[:credentials][:secret]
    provider = params[:provider]

    user = User.where( provider: provider, sns_id: uid ).first
    unless user
      user = User.create(
        provider: provider,
        sns_id: uid,
        oauth_access_token: oat,
        oauth_access_token_secret: oats
      )
      user.save
    end
    user.oauth_access_token = oat
    user.oauth_access_token_secret = oats
    user.save

    session[:user_id] = user.id
    redirect_to root_path
  end

  def failure
    redirect_to '/top/failure'
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end

end
