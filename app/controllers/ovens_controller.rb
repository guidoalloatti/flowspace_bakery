class OvensController < ApplicationController
  before_action :authenticate_user!

  def index
    @ovens = current_user.ovens
  end

  def show
    @oven = current_user.ovens.find_by!(id: params[:id])
  end

  def empty
    @oven = current_user.ovens.find_by!(id: params[:id])
    cookie = @oven.cookie
    
    if cookie
      @oven.cookie.update_attributes!(storage: current_user)

      (cookie.batch_amount-1).times do
        Cookie.create(fillings: cookie.fillings,
          status: "baked",
          storage: current_user,
          storage_id: @oven.id
        )
      end
    end
    redirect_to @oven, alert: 'Oven emptied!'
  end
end
