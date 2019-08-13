# frozen_string_literal: true

class AislesController < ApplicationController
  before_action :set_aisle, only: %i[edit update destroy]

  def index
    @aisles = current_user.aisles.by_name
  end

  def new
    @aisle = current_user.aisles.new
  end

  def create
    @aisle = current_user.aisles.new(aisle_params)
    if @aisle.save
      redirect_to aisles_url
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @aisle.update(aisle_params)
      redirect_to aisles_url
    else
      render :edit
    end
  end

  def destroy
    Aisle.find(params[:id]).destroy
    flash[:success] = 'Aisle deleted'
    redirect_to aisles_path
  end

  private

  def set_aisle
    @aisle = Aisle.find(params[:id])
  end

  def aisle_params
    params.require(:aisle).permit(:user_id, :name)
  end
end
