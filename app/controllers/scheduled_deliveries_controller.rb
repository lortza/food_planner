# frozen_string_literal: true
class ScheduledDeliveriesController < ApplicationController
  before_action :set_scheduled_delivery, only: %i[edit update destroy]
  before_action :set_shopping_list, only: %i[new create edit update destroy]

  def new
    @scheduled_delivery = @shopping_list.scheduled_deliveries.new(service_provider: 'HEB')
  end

  def create
    @scheduled_delivery = @shopping_list.scheduled_deliveries.new(scheduled_delivery_params)
    # authorize(@scheduled_delivery)

    if @scheduled_delivery.save
      redirect_to @shopping_list
    else
      render :new
    end
  end

  def edit
    # authorize(@scheduled_delivery)
  end

  def update
    # authorize(@scheduled_delivery)

    if @scheduled_delivery.update(scheduled_delivery_params)
      redirect_to @scheduled_delivery.shopping_list
    else
      render :edit
    end
  end

  def destroy
    scheduled_delivery = ScheduledDelivery.find(params[:id])
    # authorize(scheduled_delivery)

    scheduled_delivery.destroy
    flash[:success] = "Your #{@scheduled_delivery.scheduled_for.to_s(:timestamp)} delivery was deleted."
    redirect_to @scheduled_delivery.shopping_list
  end

  private

  def set_scheduled_delivery
    @scheduled_delivery = ScheduledDelivery.find(params[:id])
  end

  def set_shopping_list
    @shopping_list = current_user.shopping_lists.find(params[:shopping_list_id])
  end

  def scheduled_delivery_params
    params.require(:scheduled_delivery).permit(:shopping_list_id,
                                               :service_provider,
                                               :scheduled_for)
  end

end
