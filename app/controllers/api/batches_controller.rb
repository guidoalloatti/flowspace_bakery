module Api
  class BatchesController < ApplicationController
    before_action :authenticate_user!

    def show
      @batch = Batch.find(params[:id])
      render json: @batch.attributes
    end

    def status
      @batch = Batch.find_by(id: params[:batch_id])
      render json: { status: @batch.status }
    end

  end
end