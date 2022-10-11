class ApplicationController < ActionController::Base

  before_action :set_q

  private

  def set_q
    # params[:q]のqには検索ファームに入力した値が入る
    @q = Post.ransack(params[:q])
  end

end