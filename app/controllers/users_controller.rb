class UsersController < ApplicationController

  def dashboard
    @rentals = current_user.rentals
    @tools = current_user.tools
    @rentals_as_owner = current_user.rentals_as_owner
  end

end
