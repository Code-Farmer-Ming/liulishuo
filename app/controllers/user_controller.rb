class UserController < ApplicationController

  def show
    @users = User.all.where.not(id: current_user).page params[:page]
  end

  def follow
    user = User.where(id: params[:id]).first
    current_user.follow_users << user
    redirect_to user_path
  end

  def unfollow
    user = User.where(id: params[:id]).first
    current_user.follow_users.destroy(user)
    redirect_to user_path
  end

  def edit

  end

  def update
    if current_user.update(get_params)
      flash[:notice]=  t("global.update_success")

    end
    render 'edit'
  end

  private

  def get_params
    params.require(:user).permit(:desc)
  end
end
