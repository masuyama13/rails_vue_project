# frozen_string_literal: true

class Api::FruitsController < ApplicationController
  def destroy
    @fruit = Fruit.find(params[:id])
    if @fruit.destroy
      head :no_content
    else
      head :bad_request
    end
  end
end
