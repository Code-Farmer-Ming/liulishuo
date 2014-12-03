class RegisterController < ApplicationController
  skip_before_filter :authenticate!, :only => [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(get_params)
    if @user.save
      sign_in(@user)
      redirect_to root_path,notice: t("global.register_success")
    else
      render :'register/new'
    end
  end

  private

  def get_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end
end
