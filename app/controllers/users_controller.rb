class UsersController < ApplicationController

  def dashboard
    @rentals = current_user.rentals
    @tools = current_user.tools
    @rentals_as_owner = current_user.rentals_as_owner
    @pending_approvals = @rentals_as_owner.where(status: "pending")
    @waiting_for_return = @rentals_as_owner.where(status: "accepted")
    @my_pending = @rentals.where(status: "pending")
    @my_accepted = @rentals.where(status: "accepted")
  end
end
