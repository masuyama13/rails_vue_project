# frozen_string_literal: true

class Api::FruitsController < ApplicationController

  def create
    def create
      @fruit = Fruit.new(fruit_params)
      if @fruit.save
        render :show, status: :created, location: @fruit
      else
        render json: @fruit.errors, status: :unprocessable_entity
      end
    end
  end

  def update
    @fruit = Fruit.find(params[:id])
    if @fruit.update(fruit_params)
      render :show, status: :ok, location: @fruit
    else
      render json: @fruit.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @fruit = Fruit.find(params[:id])
    if @fruit.destroy
      head :no_content
    end
  end

  private
    def fruit_params
      params.require(:fruit).permit(:name, :description, :position)
    end
end
