class CookiesController < ApplicationController
  before_action :authenticate_user!

  def new
    @oven = current_user.ovens.find_by!(id: params[:oven_id])
    if @oven.cookie
      redirect_to @oven, alert: 'A cookie is already in the oven!'
    else
      @cookie = @oven.build_cookie
    end
  end

  def create
    @oven = current_user.ovens.find_by!(id: params[:oven_id])

    unless cookie_params[:fillings].present?
      flash[:error] = "no fillings!"
      redirect_to new_oven_cookies_path(@oven)
    else
      @cookie = @oven.create_cookie!(cookie_params)
      redirect_to oven_path(@oven)
    end
  end

  private

  def cookie_params
    params.require(:cookie).permit(:fillings)
  end
end
