class ApplicationController < ActionController::Base

  before_action :set_q

  private

  def set_q
    @q = Post.ransack(params[:q])
  end

end