class Api::V1::Items::BestDayController < ApplicationController
  def show
    render json: { "best_day" => Item.find(params[:id]).best_day }
  end
end
