# frozen_string_literal: true

class API::FruitsController < API::BaseController

  def update
    @fruit = Fruit.find(params[:id])
    if @fruit.update(fruit_params)
      head :ok
    else
      head :bad_request
    end
  end

  private
    def fruit_params
      params.require(:fruit).permit(:position)
    end
end
