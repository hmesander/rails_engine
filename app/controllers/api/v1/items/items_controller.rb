class Api::V1::Items::ItemsController < ApplicationController
  def index
    render json: Item.most_items(params[:quantity])
  end
end
