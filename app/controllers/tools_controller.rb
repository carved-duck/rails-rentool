class ToolsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show]
  def index
    @tools = Tool.all
  end

  def show
    @tool = Tool.find(params[:id])
    @rental = Rental.new
  end

  def new
    @tool = Tool.new
  end

  def create
    @tool = Tool.new(tool_params)
    @tool.user = current_user
    if @tool.save
      redirect_to tool_path(@tool)
    else
      render "tools/new", status: :unprocessable_entity
    end
  end

  private

  def tool_params
    params.require(:tool).permit(:name, :description, :location, :condition, :rental_price, :category, :photo)
  end
end
