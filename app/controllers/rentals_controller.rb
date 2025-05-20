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
      #to do: redirect to dashboard
      redirect_to tool_path(@rental.tool)
    else
      render "tools/show", status: :unprocessable_entity
    end

  end

  private

  def rental_params
    params.require(:rental).permit(:start_date)
  end
end
