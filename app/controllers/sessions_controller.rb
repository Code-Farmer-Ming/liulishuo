class SessionsController < ApplicationController
  skip_before_filter :authenticate!, :only => [:new, :create]

  def new
  end

  def create
    login_result =User.login?(get_params)
    if login_result.has_key?(:success)
      sign_in(login_result[:success])
      redirect_to root_path, notice: t("global.login_success")
    else
      flash.now[:error]= t("global.#{ login_result[:failed]}")
      render action: 'new'
    end
  end

  def destroy
    sign_out
    redirect_to login_path
  end

  private

  def get_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end
end
