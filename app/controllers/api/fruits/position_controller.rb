# frozen_string_literal: true

class Api::Fruits::PositionController < ApplicationController
  def update
    @fruit = Fruit.find(params[:fruit_id])
    if @fruit.update(fruit_params)
      head :no_content
    else
      head :bad_request
    end
  end

  private
    def fruit_params
      params.permit(:position)
    end
end
