class ToolsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show]
  def index
    @tools = Tool.all
    @markers = @tools.geocoded.map do |tool|
      {
        lat: tool.latitude,
        lng: tool.longitude
      }
    end
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
    params.require(:tool).permit(:name, :description, :location, :condition, :price, :category, :photo)
  end
end
