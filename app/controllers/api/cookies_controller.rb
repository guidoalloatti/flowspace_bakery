module Api
  class CookiesController < ApplicationController
    before_action :authenticate_user!

    def show
      @cookie = Cookie.find(params[:id])
      render json: @cookie.attributes
    end

    def status
      @cookie = Cookie.find_by(id: params[:cookie_id])
      render json: { status: @cookie.status }
    end

  end
end