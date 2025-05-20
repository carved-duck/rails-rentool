class ToolsController < ApplicationController
  def index
    @tools = Tool.all
  end

  def new
    @tool = Tool.new
  end

  def create
    @user = User.find(params[:user_id])
    @tool = Tool.new(tool_params)
    @tool.user = @user
    if tool.save
      redirect_to new_tool_path
    else
      render "tools/new", status: :unprocessable_entity
    end
  end

  def tool_params
    params.require(:tool).permit(:name, :description, :location, :condition, :rental_price, :category)
  end
end

# belongs_to :user
#   has_many :rentals

#   validates :name, presence: true
#   validates :description, presence: true
#   validates :location, presence: true
#   validates :condition, presence: true
#   validates :rental_price, presence: true
#   validates :category, presence: true
