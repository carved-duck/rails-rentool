class RentalsController < ApplicationController

  def create
    @tool = Tool.find(params[:tool_id])
    @rental = Rental.new(rental_params)
    @rental.tool = @tool
    @rental.user = current_user
    dates = params[:rental][:start_date].split(' to ')
    @rental.start_date = dates.first
    @rental.end_date = dates.last

    @rental.total_price = @tool.price * @rental.num_of_days
    if @rental.save
      redirect_to dashboard_path
    else
      render "tools/show", status: :unprocessable_entity
    end
  end

  def update
    @rental = Rental.find(params[:id])
      if @rental.update(rental_params)
        # redirect_to # up to you...
        redirect_to dashboard_path, notice: "Rental updated!"
      else
        # render # where was the rental update form?
        render "tools/show", status: :unprocessable_entity
      end
  end

  private

  def rental_params
    params.require(:rental).permit(:status, :start_date, :end_date)
  end
end
