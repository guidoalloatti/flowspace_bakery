class OvensController < ApplicationController
  before_action :authenticate_user!

  def new
  end

  def create
    current_user.ovens.create(name: oven_params[:name])
    redirect_to ovens_path
  end

  def index
    @count = current_user.ovens.count
    @ovens = current_user.ovens
    @oven = current_user.ovens.new
  end

  def show
    @oven = current_user.ovens.find_by!(id: params[:id])
    
    @is_ready = @oven.batches.all? { |b| b.ready? }
    @is_baking = @oven.batches.any? { |b| b.baking? }
    @is_empty = @oven.batches.all? { |b| b.cookies.count == 0 }
    
    if @oven.batches.last
      @batch = @oven.batches.last
      @fillings = @batch.filling
      @size = @batch.size
      @batch_id = @batch.id
    end
  end

  def empty
    @oven = current_user.ovens.find_by!(id: params[:id])
    batch = @oven.batches.last
    
    batch&.cookies&.each do |cookie|
      cookie = Cookie.find(cookie.id)
      cookie.update_attributes!(storage: current_user)
      cookie.update_attributes!(batch_id: nil)
      cookie.save!
    end

    redirect_to @oven, alert: 'Oven emptied!'
  end

  def destroy
    @oven = Oven.find(params[:id])
    @oven.batches.destroy_all
    @oven.destroy
    # Oven.destroy(params[:id])
    redirect_to ovens_path
  end

  private

  def oven_params
    params.require(:oven).permit(:name)
  end
end
