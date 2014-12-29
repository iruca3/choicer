class TopController < ApplicationController

  def index
    unless current_user
      render 'top/login' and return
    end
  end

end
