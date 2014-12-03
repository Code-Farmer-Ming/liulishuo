class HomeController < ApplicationController
  def index
    @histories = current_user.followed_descs.order('created_at desc').page(params[:page])
  end
end

