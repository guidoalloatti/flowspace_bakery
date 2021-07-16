class CookiesController < ApplicationController
  before_action :authenticate_user!

  def new
    @oven = current_user.ovens.find_by!(id: params[:oven_id])
    
    if @oven.batches&.last&.cookies&.any?
      redirect_to @oven, alert: 'Some cookies are already in the oven!'
    else
      @cookie = Cookie.new
    end
  end

  def create
    batch_size = cookie_params[:batch_amount].to_i
    @oven = current_user.ovens.find_by!(id: params[:oven_id])

    @batch = @oven.batches.create({
      filling: cookie_params[:fillings],
      size: cookie_params[:batch_amount],
      status: 'baking'
    })

    @batch.size.times do
      @batch.cookies.create!(cookie_params.merge!({batch_id: @batch.id}))
    end

    ::CookieBakerWorker.perform_async(@batch.id)
    
    redirect_to oven_path(@oven)
  end

  private

  def cookie_params
    params.require(:cookie).permit(:fillings, :batch_amount)
  end
end
